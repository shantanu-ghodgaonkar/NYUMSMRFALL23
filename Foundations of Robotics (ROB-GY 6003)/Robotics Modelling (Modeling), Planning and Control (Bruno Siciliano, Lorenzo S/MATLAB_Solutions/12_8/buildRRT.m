function [graph state] = buildRRT( qStart, qGoal, robot, obstacles, nVertices, motionPrimitiveCommandArray, delta, threshold, probBiasedExpansion )%
%   inputs:
%   nVertices = maximum number of vertices
%   motionPrimitiveCommandArray = array of commands [v_1 omega_1; v_2 omega_2; ... ; v_n omega_n] by which motion primitives are generated
%   delta = time interval length for which a vector command [v_i omega_i] is applied to the robot dynamic model for generating the i-th motion primitive
%   threshold = distance threshold; when a configuration q of the tree is close at least threshold from qGoal, the algorithm stops
%   probBiasedExpansion = the probability of a goal-biased expansion, i.e.
%   the probability that qRand is forced to qGoal

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

%% Interactive Expansion

plotFlag = 0; % set this flag to 1 if you want to see an interactive expansion of the RRT


%% Initialization

graph.verts = [];                             % list of vertices: graph.verts(i,:) is the i-th stored configuration  
graph.vertsIndexArrayFreePrimitives = [];     % graph.vertsIndexArrayFreePrimitives(i,j) = 0 -> the j-th motion primitive has been already used from vertex graph.verts(i,:)    
                                              %                                          = 1 -> the j-th motion primitive has not been used yet 
graph.adjMat = sparse(nVertices,nVertices,0); % adjacency matrix of an oriented graph
% graph.adjMat(i,j) = 0 -> no edge exists between between graph.verts(i,:) and graph.verts(j,:)
%                   = d -> 
%                     if (d == 1)
%                        an edge exists from graph.verts(i,:) to graph.verts(j,:)
%                     elseif (d == -1)
%                        an edge exists from graph.verts(j,:) to graph.verts(i,:)
%                     end 
% Hence, if we are building a tree, the parent vertex of graph.verts(i) is the unique j-th vertex such that graph.adjMat(i,j) < 0,
% all the other vertices such that graph.adjMat(i,j) > 0 are children of the i-th vertex. 

graph.adjMat4Edges = sparse(nVertices,nVertices,0); % adjacency matrix for edges identification
graph.vectorEdges = {};                             % list of edges; each edge represents a path in the form of a sequence of configurations [q1; q2; ...; qm]
% graph.adjMat4Edges(i,j) = 0 -> no edge exists between between graph.verts(i,:) and graph.verts(j,:)
%                         = e -> 
%                          if e>0   
%                            graph.vectorEdges(abs(e)) is the oriented path connecting graph.verts(i,:) to graph.verts(j,:) in the C-space manifold 
%                          else
%                            graph.vectorEdges(abs(e)) is the oriented path connecting graph.verts(j,:) to graph.verts(i,:) in the C-space manifold
%                          end
jointRanges = robot.jointRanges;
nPrimitives = size(motionPrimitiveCommandArray,1); % number of motion primitives

graph.verts(1,:) = qStart; % insert first vertex
graph.vertsIndexArrayFreePrimitives(1,:) = ones(1,nPrimitives);

if plotFlag ==1 % set the appearance of the markers for qRand, qNear, qNew
    subplot(1,2,2);
    hRand = plot3(qStart(1), qStart(2), wrap(qStart(3)),'o','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',10);
    hNear = plot3(qStart(1), qStart(2), wrap(qStart(3)),'o','MarkerEdgeColor','r','MarkerFaceColor','none','MarkerSize',10);
    hNew  = plot3(qStart(1), qStart(2), wrap(qStart(3)),'o','MarkerEdgeColor','r','MarkerFaceColor','k','MarkerSize',10);
end

rand('twister', sum(100*clock));  % init random number generator

%% Main loop 
for s = 1:(nVertices-1)
    
    fprintf(1,'sample %d\n',s);
    
    % generate a random configuration
    qRand = randomConfig(robot);    
    
    % goal-biased expansion 
    coin = rand(); % toss a coin
    if coin <= probBiasedExpansion 
        qRand = qGoal; % force qRand = qGoal -> this biases the RRT expansion towards the goal qGoal
        disp('goal-biased expansion: qRand forced to qGoal')
    end

    % collision checking
    if ~isCollisionFree(robot, obstacles, qRand)
        continue; % jump to the next cycle
    end

    % Find the configuration in the graph which is closest to qRand and has at least a free motion primitive
    [sortedDists, indices] = findSortedNeighbors(  graph.verts, qRand, jointRanges );
    
    for i=1:size(graph.verts,1)
        if norm( graph.vertsIndexArrayFreePrimitives(indices(i),:) ) > 0 % if graph.verts(indices(i),:) has at least a free motion primitive 
            qNear = graph.verts(indices(i),:);
            indexqNear = indices(i);
            break;
        end
    end
    
    % generate a new configuration qNew 
    % 1) make a motion from qNear towards qRand by applying a free command [v_i omega_i] 
    %    in the array motionPrimitiveCommandArray for a time increment delta 
    % 2) select the generated motion which is collision free and ends in the
    %    configuration qNew which is closest to qRand 
    
    indexArrayFreePrimitives = graph.vertsIndexArrayFreePrimitives(indexqNear,:); % extract the array representing the free primitives of qNear
    [qNew ,path , indexArrayUsedPrimitive, state] = newConfiguration( qRand, qNear, qGoal, motionPrimitiveCommandArray, indexArrayFreePrimitives, delta , threshold, robot, obstacles); 
    fprintf(1,'state = %s\n',state);
    
    switch state
           
        case 'advanced' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
               % interactive plot
               if plotFlag ==1
                   subplot(1,2,2);
                   set(hRand,'xdata',qRand(1),'ydata',qRand(2),'zdata',wrap(qRand(3)));
                   set(hNear,'xdata',qNear(1),'ydata',qNear(2),'zdata',wrap(qNear(3)));
                   set(hNew,'xdata',qNew(1),'ydata',qNew(2),'zdata',wrap(qNew(3)));
                   
                   subplot(1,2,1);
                   robot.positionedLinkArray = forwardKinematics(robot,qNew);
                   drawRobot(robot,'k','y');
                   
                   shg;
                   disp('press enter to continue')
                   pause;
                   
                   subplot(1,2,2);
                   plot3(qNew(1), qNew(2), wrap(qNew(3)),'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',6);
               end
               
               % update the free primitives' array of the vertex qNear
               for h=1:length(indexArrayUsedPrimitive)
                   graph.vertsIndexArrayFreePrimitives(indexqNear,indexArrayUsedPrimitive(h)) = 0;
               end
               
                % insert new vertex in the tree structure
               graph.verts(end+1,:) = qNew;    
               graph.vertsIndexArrayFreePrimitives(end+1,:) = ones(1,nPrimitives);
               
               % insert new edge in the tree structure
               graph.vectorEdges{end+1} = path;   
               
               % update adjacency matrices
               graph.adjMat(indexqNear,size(graph.verts,1)) = 1; 
               graph.adjMat4Edges(indexqNear,size(graph.verts,1)) = length(graph.vectorEdges); 
        
        case 'reached' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
               % update the free primitives' array of the vertex qNear
               for h=1:length(indexArrayUsedPrimitive)
                   graph.vertsIndexArrayFreePrimitives(indexqNear,indexArrayUsedPrimitive(h)) = 0;
               end
               
                % insert new vertex in the tree structure
               graph.verts(end+1,:) = qNew;    
               graph.vertsIndexArrayFreePrimitives(end+1,:) = ones(1,nPrimitives);
               
               % insert new edge in the tree structure
               graph.vectorEdges{end+1} = path;   
               
               % update adjacency matrices
               graph.adjMat(indexqNear,size(graph.verts,1)) = 1; 
               graph.adjMat4Edges(indexqNear,size(graph.verts,1)) = length(graph.vectorEdges); 
               
               break; % exit from the loop
        
        case 'trapped' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              
        otherwise      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               error('unknown state')
    end    
        

end

graph.adjMat=(graph.adjMat - graph.adjMat'); % the adjacency matrix adjMat is antisymmetric
graph.adjMat4Edges=(graph.adjMat4Edges - graph.adjMat4Edges'); % the adjacency matrix adjMat4Edges is antisymmetric


if plotFlag ==1
    far = 100000000000000.0;
    set(hRand,'xdata',far,'ydata',far,'zdata',far);
    set(hNear,'xdata',far,'ydata',far,'zdata',far);
    set(hNew,'xdata',far,'ydata',far,'zdata',far);
end

    