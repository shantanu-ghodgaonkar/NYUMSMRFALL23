function graph = buildPRM( robot, obstacles, nVertices, maxNumNeighbors, maxNeighborDistance )
% inspired by the function by Prof. David Johnson
% http://www.eng.utah.edu/~cs6370/Assignment4.html
%
%   inputs:
%   nVertices = maximum number of vertices
%   nNeighbors = desired number of neighbors
%   maxNeighborDistance = maximum distance for searching neighbors

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

%% Initialization

graph.verts = [];                             % list of vertices: graph.verts(i,:) is the i-th stored vertex
graph.adjMat = sparse(nVertices,nVertices,0); % adjacency matrix
% graph.adjMat(i,j) = 0 -> no edge exists between between graph.verts(i,:) and graph.verts(j,:)
%                   = d -> an edge representing a path of lenght d exists between graph.verts(i,:) and graph.verts(j,:)  
graph.adjMat4Edges = sparse(nVertices,nVertices,0); % adjacency matrix for edges
graph.vectorEdges = [];                       % list of vector edges
% graph.adjMat4Edges(i,j) = 0 -> no edge exists between between graph.verts(i,:) and graph.verts(j,:)
%                         = e -> 
%                          if e>0   
%                            +graph.vectorEdges(abs(e)) is the shortest vector from graph.verts(i) to graph.verts(j,:) in the C-space manifold 
%                          else
%                            -graph.vectorEdges(abs(e)) is the shortest vector from graph.verts(i) to graph.verts(j,:) in the C-space manifold
% It is worth noting that the so built adjancecy matrix graph.adjMat4Edges is antisimmetric. 

jointRanges = robot.jointRanges;

rand('twister', sum(100*clock));  % init random number generator

%% Main loop 
for s = 1:nVertices
    
    fprintf(1,'sample %d\n',s);
    
    % generate a random configuration
    qRand = randomConfig(robot);
    
    % collision checking
    if ~isCollisionFree(robot, obstacles, qRand) % if qRand is not collision free
        continue; % jump to the next cycle
    end

    
    % at this point, configuration is collision free 

    if ( size(graph.verts,1) == 0 )     % if graph is empty
        graph.verts(end+1,:) = qRand;   % insert first vertex
        continue;                       % jump to the next cycle
    end
    
    graph.verts(end+1,:) = qRand;     % add a new vertex to the graph
        
    % Find the neighbor vertices, sorted by distance
    [sortedDists, indices] = findSortedNeighbors(  graph.verts, qRand, jointRanges );
    

    % Search the sorted list and try to connect qRand with
    % the vertices in the graph. Stop after connecting maxNumNeighbors
    % vertices or if the distances grow larger than maxNeighborDistance
   
    nNeighbor=0;  % number of connected neighbors
    for i = 1:length(indices)
        if ( sortedDists(i) < maxNeighborDistance ) && (nNeighbor < maxNumNeighbors)
            [ dist, delta ] = connect( robot, obstacles, qRand, graph.verts(indices(i),:), ceil(10*sortedDists(i))+2 );
            if ( dist>0 )
                nNeighbor = nNeighbor +1;
                
                graph.adjMat(size(graph.verts,1),indices(i)) = dist;
               
                
                graph.vectorEdges(end+1,:) = delta; % add a new edge to the list of edges
                graph.adjMat4Edges(size(graph.verts,1),indices(i)) = +size(graph.vectorEdges,1); 
                
            end
        else
            break;
        end
    end
    
end

graph.adjMat=(graph.adjMat + graph.adjMat'); % the adjacency matrix adjMat is symmetric
graph.adjMat4Edges=(graph.adjMat4Edges-graph.adjMat4Edges'); % the adjacency matrix adjMat4Edges is antisymmetric

    