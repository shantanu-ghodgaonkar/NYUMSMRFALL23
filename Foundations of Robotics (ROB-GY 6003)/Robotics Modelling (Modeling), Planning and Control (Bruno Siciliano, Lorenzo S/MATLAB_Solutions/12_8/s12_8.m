% s12_8   Solution to Problem 12.8
% RRT-based motion planning for a unicycle robot
 
% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all;
close all;

%% Create a planar robot
% The robot is a sequence of links connected by joints.
% The first joint is a translational+rotational joint which defines the first link configuration (x1 y1 q1). 
% The other joints are purely rotational (qi, i>1). 
% Hence, a robot configuration is q = [x1 y1 q1 q2 ... qn]
% Each robot LINK and each OBSTACLE are collection of basic bodies.
% A BASIC BODY can be a line segment, a circle or a polygon.
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
link.bodyArray = { createPolygon([-0.1 -0.2; -0.1 0.2; 0.5 0]) createCircle([0 0], 0.03 ) };

% define the array of joint centers, 
% i.e. the origin of a link in the frame of the previous link (link1 is positioned w.r.t the world frame)
jointArray = [0.0 0.0];

% define the array of joint ranges 
% jointRanges = [x1Min x1Max; y1Min y1Max; q1Min q1Max; q2Min q2Max; ... ; qnMin qnMax];
% for a fixed-base manipulator -> x1Min=x1Max=y1Min=y1Max=0;
jointRanges = [-5 5; -5 5; -pi pi];           

%create robot
robot = createRobot({link}, jointArray, jointRanges);

%% Create the obstacles
%an obstacle can be a {circle, line, polygon}

obstacleArray = { createCircle( [-2 -0.9], 0.3) createCircle([0.8 1.5], 0.2 ) createCircle( [0 -1], 0.3)... 
    createCircle( [-2 0.9], 0.3) createPolygon([0 0; 0.5 0; 0.5 1; 0 1]) ...
    createPolygon([0 -2.5; 0.5 -2.5; 0.5 -3; 0 -3]) createPolygon([2 -0.5; 2.5 -0.5; 2.5 -1; 2 -1]) };
   
%% Draw Workspace

figure(1); 
subplot(1,2,1); daspect([1 1 1]); hold on; box on;
axis( [ jointRanges(1,:) jointRanges(2,:) ]);
set(gca,'fontname','Times','fontsize',18,'fontweight','normal');
title('workspace');
%set(findobj(gca,'type','text'),'HandleVisibility','off');

% draw robot
robotFaceColor = 'y';
robotEdgeColor = 'k';
%q = zeros(1,robot.nLinks+2);
%robot.positionedLinkArray = forwardKinematics(robot,q);
%drawRobot(robot,robotEdgeColor,robotFaceColor);

% draw obstacles
obstacleFaceColor = 'b';
obstacleEdgeColor = 'k';
drawObstacles(obstacleArray,obstacleEdgeColor,obstacleFaceColor);

%% Choose a start and goal configurations
% q = [x1 y1 q1 q2 ... qn]
qStart = [-3 0 0]; 
qGoal   = [3 -3.5 0];

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

%% Set-up C-space Plot

subplot(1,2,2); daspect([1 1 1]); view([1,-1,1]);hold on;  box on;
axis( [ jointRanges(1,:) jointRanges(2,:) jointRanges(3,:)]);  
set(gca,'fontname','Times','fontsize',18,'fontweight','normal');
title('configuration space');
xlabel('x');ylabel('y');zlabel('\theta','Rotation',0);
quiver3(0,0,0,1,0,0,'k');quiver3(0,0,0,0,1,0,'k');quiver3(0,0,0,0,0,1,'k'); % draw the axes

% plot the start and goal configurations
plot3(qStart(1), qStart(2), wrap(qStart(3)),'o','MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',8);
plot3(qGoal(1), qGoal(2), wrap(qGoal(3)),'o','MarkerEdgeColor','b','MarkerFaceColor','g','MarkerSize',8);
shg;

%% Build the RRT

nVertices = 200; % maximum number of vertices

% now choose the motion primitives
motionPrimitiveCommandArray = [1 0; 1 1.3; 1 -1.3]; % array of commands [v_1 omega_1; v_2 omega_2; ... ; v_n omega_n] by which motion primitives are generated
delta = 0.9; % time interval length for which a vector command [v_i omega_i] is applied to the robot dynamic model for generating the i-th motion primitive

threshold = 0.01; % distance threshold;  the algorithm stops when the distance between a new configuration qNew of the tree and qGoal is smaller than threshold 
probBiasedExpansion = 0.2; % the probability of a goal-biased expansion, i.e. the probability that qRand is forced to qGoal

% Build the RRT
[ RRT state] = buildRRT( qStart, qGoal, robot, obstacleArray, nVertices, motionPrimitiveCommandArray, delta, threshold, probBiasedExpansion );

switch state
    case 'reached'
            success = true;
            disp('RRT has reached the final configuration')
    otherwise
            success = false;
            disp('Warning: No solution has been found!')
            disp('         No RRT configuration is within the threshold from qGoal')
end 


%% Draw the RRT

% Draw every node as a robot in workspace
subplot(1,2,1);
for j = 1:1:size(RRT.verts,1)
    q = RRT.verts(j,:);
    robot.positionedLinkArray = forwardKinematics(robot,q);
    drawRobot(robot,robotEdgeColor,robotFaceColor);
end

% Draw all edges of graph in the workspace ([x1 y1]-projection of C-space)
subplot(1,2,1);
[i, j, s] = find( RRT.adjMat4Edges);
 for h = 1:length(i)
           e = s(h); % = RM.adjMat4Edges(i(h),j(h));
           if  e>0 
               edgePath = RRT.vectorEdges{abs(e)};
               x1=edgePath(:,1)';y1=edgePath(:,2)';
               line(x1,y1,'color','k');
           end
 end

% Draw all nodes in the C-space
subplot(1,2,2);
for j = 1:size(RRT.verts,1)
    q = RRT.verts(j,:);
    % q = [x1 y1 q1 q2 ... qn]
    plot3(q(1), q(2), wrap(q(3)),'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',6);
end

% Draw all edges of graph in the C-space
subplot(1,2,2);
[i, j, s] = find( RRT.adjMat4Edges);
 for h = 1:length(i)
           e = s(h); % = RM.adjMat4Edges(i(h),j(h));
           if  e>0 
               edgePath = RRT.vectorEdges{abs(e)};
               drawCspaceProjX1Y1Q1Line( edgePath);
           end
 end
 maxWindow;
 shg;
 
%% Find the closest vertex to qGoal 

% find the configuration qClose in the graph which is closest to qRand
[sortedDists, indices] = findSortedNeighbors(  RRT.verts, qGoal, jointRanges ); % -> qClose = RRT.verts(indices(1))
fprintf(1,'         the smallest distance to qGoal is %f\n',sortedDists(1));

 % find the path from the root (qStart) to qClose = RRT.verts(indices(1))
path = findPath2Root (indices(1) , RRT); % the returned path is a sequence of configurations [q1; q2; ... qm]


%% Only if a solution has been found

if success      

%% Draw the path

    % draw the path in the configuration space
    subplot(1,2,2);
    H = drawCspaceProjX1Y1Q1Line( path, 'g');
    set(H,'LineWidth',3);

    % copy figure 1 in figure 2  
    h1 = figure(1); 
    h2 = figure(2); clf;
    copyobj(allchild(h1),h2);

    % delete graphic plots from subplot(1,2,1)
    subplot(1,2,1);
    %hPlot = findall(gca,'type','patch','-or','type','line'); 
    hPlot = findall(gca,'type','patch'); 
    delete(hPlot);

    % redraw obstacles
    drawObstacles(obstacleArray,obstacleEdgeColor,obstacleFaceColor);

    % draw the goal configurations in the workspace
    robot.positionedLinkArray = forwardKinematics(robot,qGoal);
    drawRobot(robot,'b','g');

     % draw a stobo story of the robot motion along the computed path in the workspace
    pathLength = size(path,1);
    for i = 1:10:pathLength
                q = path(i,:);
                robot.positionedLinkArray = forwardKinematics(robot,q);
                drawRobot(robot,robotEdgeColor,robotFaceColor);
    end
    robot.positionedLinkArray = forwardKinematics(robot,path(end,:));
    drawRobot(robot,robotEdgeColor,robotFaceColor);

    % Draw all edges of graph in the workspace ([x1 y1]-projection of C-space)
    [i, j, s] = find( RRT.adjMat4Edges);
     for h = 1:length(i)
               e = s(h); % = RM.adjMat4Edges(i(h),j(h));
               if  e>0 
                   edgePath = RRT.vectorEdges{abs(e)};
                   x1=edgePath(:,1)';y1=edgePath(:,2)';
                   line(x1,y1,'color','k');
               end
     end

    subplot(1,2,2);
    set(get(gca,'zlabel'),'Rotation',0); % correct the orientation of the zlabel

    maxWindow;
    shg;

%% Move the robot along the computed path

    disp('press enter to watch the animation')
    pause;

    subplot(1,2,1);
    range = axis;

    % copy figure 1 in figure 3
    h1 = figure(1);
    h2 = figure(3); clf;
    copyobj(allchild(h1),h2);
    maxWindow;

    subplot(1,2,2);
    hC= plot3(qStart(1), qStart(2), qStart(3),'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',6);
    set(get(gca,'zlabel'),'Rotation',0); % correct the orientation of the zlabel
    shg;

    pathLength = size(path,1);
    for i = 1:5:pathLength
        q = path(i,:);

        subplot(1,2,1,'replace');
        daspect([1 1 1]); axis(range); hold on; box on;
        set(gca,'fontname','Times','fontsize',18,'fontweight','normal');
        title('workspace');

        drawObstacles(obstacleArray,obstacleEdgeColor,obstacleFaceColor);
        % draw the goal configurations in the workspace
        robot.positionedLinkArray = forwardKinematics(robot,qGoal);
        drawRobot(robot,'b','g');

        robot.positionedLinkArray = forwardKinematics(robot,q);
        drawRobot(robot,robotEdgeColor,robotFaceColor);

        subplot(1,2,2);
        set(hC,'xdata',q(1),'ydata',q(2),'zdata',q(3));

        pause(0.1);
    end

    subplot(1,2,2);
    set(hC,'xdata',qGoal(1),'ydata',qGoal(2),'zdata',qGoal(3));

    shg;

%%

end

