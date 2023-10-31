% s12_7   Solution to Problem 12.7
% PRM-based motion planning for planar manipulators
 
% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all;
close all;

%% Create a planar robot
% The robot is a sequence of links connected by joints.
% The first joint is a translational+rotational joint which defines the first link configuration (x1 y1 q1). 
% The other joints are purely rotational (qi, i>1) 
% Hence, a robot configuration is q = [x1 y1 q1 q2 ... qn]
% Each robot LINK and each OBSTACLE are collection of basic bodies
% A BASIC BODY can be a line segment, a circle or a polygon
% Use: createLineSeg(), createCircle(), createPolygon()

%- BASIC BODY structure
% body.type = 'line', 'circle', 'polygon'
% body.pointArray
% body.nPoints
% body.boundingBox = [xMin yMin; xMax yMax;]
% ... (possible other member variables)

%- LINK structure 
% link.bodyArray
% link.nBodies

%- ROBOT structure 
% robot.q
% robot.linkArray = {link1 link2 ... linkn } 
% robot.positionedLinkArray
% robot.nLinks
% robot.jointArray
% robot.jointLimits


% first, build the robot links as collection of basic bodies
%link1.bodyArray = { createLineSeg([0.0 0.0; 1 0.0]) createCircle([1.0 0.0],0.02)};
%link2.bodyArray = { createLineSeg([0.0 0.0; 1 0.0]) };
link1.bodyArray = { createPolygon([0.0 -0.05; 1.0 -0.05; 1.0 0.05; 0.0 0.05]) createCircle([0.0 0.0],0.05) };
link2.bodyArray = { createPolygon([0.0 -0.05; 1.0 -0.05; 1.0 0.05; 0.0 0.05]) createCircle([0.0 0.0],0.05) };
%link3.bodyArray = { createPolygon([0.0 -0.05; 1.0 -0.05; 1.0 0.05; 0.0 0.05]) createCircle([0.0 0.0],0.05) };

% define the array of joint centers
% i.e. the origin of a link in the frame of the previous link (link1 is positioned w.r.t the world frame)
jointArray = [0.0 0.0; 1.0 0.0];
%jointArray = [0.0 0.0; 1.0 0.0; 1.0 0.0];

% define the array of joint ranges 
% jointRanges = [x1Min x1Max; y1Min y1Max; q1Min q1Max; q2Min q2Max; ... ; qnMin qnMax];
% for a fixed-base manipulator -> x1Min=x1Max=y1Min=y1Max=0;
jointRanges = [0 0; 0 0; -pi pi; -pi pi];            % fixed-base 2R manipulator
%jointRanges = [-0.5 0.5; -0.5 0.5; -pi pi; -pi pi];  % mobile 2R manipulator
%jointRanges = [0 0; 0 0; -pi pi; -pi pi; -pi pi];   % fixed-base 3R manipulator

%create robot
robot = createRobot({link1 link2 }, jointArray, jointRanges);

%% Create the obstacles
% an obstacle can be a {circle, line, polygon}

obstacleArray = {createCircle([-0.8 1.2], 0.2 ) createCircle( [-1.2 -0.9], 0.3) ...
       createCircle([1.3 1.5], 0.2 ) createCircle( [-1.2 0.9], 0.3) createPolygon([0 0.5; 0.5 0.5; 0.5 1; 0 1]) };
   

%% Draw workspace

figure(1); %clf
subplot(1,2,1);axis square; daspect([1 1 1]); hold on; box on;
set(gca,'fontname','Times','fontsize',18,'fontweight','normal');
title('workspace');

% draw robot
robotFaceColor = 'y';
robotEdgeColor = 'k';
%q = zeros(1,robot.nLinks+2);
%robot.positionedLinkArray = forwardKinematics(robot,q);
%drawRobot(robot,robotEdgeColor,FaceColor);

% draw obstacles
obstacleFaceColor = 'b';
obstacleEdgeColor = 'k';
drawObstacles(obstacleArray,obstacleEdgeColor,obstacleFaceColor);

%% Choose a start and goal configurations
% q = [x1 y1 q1 q2 ... qn]

qStart = [0 0 -pi/4 3*pi/4]; 
qGoal   = [0 0 5*pi/8 -pi/2];

% check if start and goal configurations are collision free
if (~isCollisionFree(robot, obstacleArray, qStart)) || (~isCollisionFree(robot, obstacleArray, qGoal))
        robot.positionedLinkArray = forwardKinematics(robot,qStart);
        drawRobot(robot,robotEdgeColor,robotFaceColor);
        robot.positionedLinkArray = forwardKinematics(robot,qGoal);
        drawRobot(robot,robotEdgeColor,robotFaceColor);
        drawObstacles(obstacleArray,obstacleEdgeColor,obstacleFaceColor);
        maxWindow;
        error('start/goal configuration is not collision free!')
end

% draw the start and goal configurations in the workspace
subplot(1,2,1);
robot.positionedLinkArray = forwardKinematics(robot,qStart);
drawRobot(robot,'b','y');
robot.positionedLinkArray = forwardKinematics(robot,qGoal);
drawRobot(robot,'b','g');
%shg;

%% Set-up C-space plot ( [q1 q2]-projection )

subplot(1,2,2); daspect([1 1 1]); hold on;  box on;
axis([-pi pi -pi pi]); 
set(gca,'fontname','Times','fontsize',18,'fontweight','normal');
title('configuration space');

% plot the start and goal configurations
plot(qStart(3), qStart(4),'o','MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',8);
plot(qGoal(3), qGoal(4),'o','MarkerEdgeColor','b','MarkerFaceColor','g','MarkerSize',8);
shg;

%% Build the PRM 

nVertices = 50; % maximum number of vertices
maxNumNeighbors = 3; % desired number of neighbors
maxNeighborDistance = 3; % maximum distance for searching neighbors

% Build the roadmap
PRM = buildPRM( robot, obstacleArray, nVertices, maxNumNeighbors, maxNeighborDistance );
 

%% Attach the start and goal configurations to the PRM

[ PRM  startVertexIndex ]  = addVertex2PRM(qStart, PRM, robot, obstacleArray, maxNumNeighbors, maxNeighborDistance );
[ PRM  goalVertexIndex  ]  = addVertex2PRM(qGoal, PRM, robot, obstacleArray, maxNumNeighbors, maxNeighborDistance );


%% Draw the PRM 

% Draw every node as a robot in workspace
subplot(1,2,1);
for j = 1:1:size(PRM.verts,1)
    q = PRM.verts(j,:);
    robot.positionedLinkArray = forwardKinematics(robot,q);
    drawRobot(robot,robotEdgeColor,robotFaceColor);
end

% Draw all nodes in the [q1 q2]-projection C-space
subplot(1,2,2);

for j = 1:size(PRM.verts,1)
    q = PRM.verts(j,:);
    % q = [x1 y1 q1 q2 ... qn]
    plot(q(3), q(4),'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',6);
end

% Draw all edges of graph in the [q1 q2]-projection C-space
[i, j, s] = find( PRM.adjMat4Edges);
 for h = 1:length(i)

           e = s(h); % = PRM.adjMat(i(h),j(h));
           delta = PRM.vectorEdges(abs(e),:);
            if  e>0 
                arc = createLineSeg( [ PRM.verts(i(h),3:4); (PRM.verts(i(h),3:4)+delta(3:4)) ] );
                drawLineSeg( arc );
            else
                arc = createLineSeg( [ PRM.verts(i(h),3:4); (PRM.verts(i(h),3:4)-delta(3:4)) ] );
                drawLineSeg( arc );
            end
     
 end
  
% plot the start and goal configurations 
plot(qStart(3), qStart(4),'o','MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',8);
plot(qGoal(3), qGoal(4),'o','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',8);
    
maxWindow;
 
%% Use Dijkstra's algorithm to find the shortest path

path = dijkstra( size(PRM.verts,1), PRM.adjMat, startVertexIndex, goalVertexIndex);

failure = false;
if isempty(path)
    failure = true;
    disp('Warning: no solution has been found')
end

%% Draw the path 

% draw a strobo story of the robot motion along the path in the workspace
subplot(1,2,1); range = axis;
subplot(1,2,1,'reset');
daspect([1 1 1]); axis(range); hold on; box on; 
set(gca,'fontname','Times','fontsize',18,'fontweight','normal');
title('workspace');

drawObstacles(obstacleArray,obstacleEdgeColor,obstacleFaceColor);

% draw the start configuration in the workspace
subplot(1,2,1);
robot.positionedLinkArray = forwardKinematics(robot,qStart);
drawRobot(robot,'b','y');

for i = 1:length(path)-1
        e = PRM.adjMat4Edges(path(i),path(i+1));
        if  e>0 
            delta = PRM.vectorEdges(abs(e),:);
        else
            delta = - PRM.vectorEdges(abs(e),:);
        end

        for t = 0:0.25:1    
            interpq = PRM.verts(path(i),:) + t * delta;
            robot.positionedLinkArray = forwardKinematics(robot,interpq);
            drawRobot(robot,robotEdgeColor,robotFaceColor);
        end
end

% draw the path in the configuration space
subplot(1,2,2);
for i = 1:length(path)-1
    
    e = PRM.adjMat4Edges(path(i),path(i+1));
    delta = PRM.vectorEdges(abs(e),:);
    if  e>0 
        arc = createLineSeg( [ PRM.verts(path(i),3:4); (PRM.verts(path(i),3:4)+delta(3:4)) ] );
        h   = drawLineSeg(arc,'g');
    else
        arc = createLineSeg( [ PRM.verts(path(i),3:4); (PRM.verts(path(i),3:4)-delta(3:4)) ] );
        h   = drawLineSeg(arc,'g');
    end
    set(h,'LineWidth',3)  
    
    e = PRM.adjMat4Edges(path(i+1),path(i));
    delta = PRM.vectorEdges(abs(e),:);
    if  e>0 
        arc = createLineSeg( [ PRM.verts(path(i+1),3:4); (PRM.verts(path(i+1),3:4)+delta(3:4)) ] );
        h   = drawLineSeg(arc,'g');
    else
        arc = createLineSeg( [ PRM.verts(path(i+1),3:4); (PRM.verts(path(i+1),3:4)-delta(3:4)) ] );
        h   = drawLineSeg(arc,'g');
    end
    set(h,'LineWidth',3)  
    
end

 
% plot the start and goal configurations 
plot(qStart(3), qStart(4),'o','MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',8);
plot(qGoal(3), qGoal(4),'o','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',8);

% draw the goal configuration in the workspace
subplot(1,2,1);
robot.positionedLinkArray = forwardKinematics(robot,qGoal);
drawRobot(robot,'b','g');

 
shg;

%% Move the robot along the computed path

if failure == false 
    disp('press enter to watch the animation')
    pause;
end


subplot(1,2,1);
range = axis;

subplot(1,2,2);
hC= plot(qStart(3), qStart(4),'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',6);
shg;

for i = 1:length(path)-1
        
        e = PRM.adjMat4Edges(path(i),path(i+1));
        if  e>0 
            delta = PRM.vectorEdges(abs(e),:);
        else
            delta = - PRM.vectorEdges(abs(e),:);
        end

        for t = 0:0.1:1
            
            h = subplot(1,2,1,'replace'); daspect([1 1 1]); axis(range); hold on; box on; 
            set(gca,'fontname','Times','fontsize',18,'fontweight','normal');
            title('workspace'); 
            
            drawObstacles(obstacleArray,obstacleEdgeColor,obstacleFaceColor);
      
            interpq = PRM.verts(path(i),:) + t * delta;
            robot.positionedLinkArray = forwardKinematics(robot,interpq);
            drawRobot(robot,robotEdgeColor,robotFaceColor);
            
            subplot(1,2,2);
            set(hC,'xdata',interpq(3),'ydata',interpq(4));
            
            pause(0.1);
        end
end

subplot(1,2,2);
set(hC,'xdata',qGoal(3),'ydata',qGoal(4));
shg;

