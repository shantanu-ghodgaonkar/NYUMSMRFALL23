function [graph index] = addVertex2PRM(q, graph, robot, obstacles, maxNumNeighbors, maxNeighborDistance )
% add a new vertex containing q to the graph
% outputs:
% graph = the modified graph
% index = the index of the new vertex in the graph.verts list

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ( size(graph.verts,1) == 0 )     % graph is void
        graph.verts(end+1,:) = q; % insert first vertex
        index = 1;
        return;
end
    
graph.verts(end+1,:) = q;     % insert vertex in the graph
index = size(graph.verts,1);

graph.adjMat(size(graph.verts,1),size(graph.verts,1)) = 0;       % increase matrix dimensions if needed
graph.adjMat4Edges(size(graph.verts,1),size(graph.verts,1)) = 0; % increase matrix dimensions if needed

     
% Find the neighbor vertices, sorted by distance
[sortedDists, indices] = findSortedNeighbors( graph.verts, q, robot.jointRanges);


% Search the sorted list and try to connect q with
% the vertices in the graph. Stop after connecting maxNumNeighbors
% vertices or if the distances grow larger than maxNeighborDistance

    nNeighbor=0;  % number of connected neighbors
    for i = 1:length(indices)
        if ( sortedDists(i) < maxNeighborDistance ) && (nNeighbor < maxNumNeighbors)
            [ dist, delta ] = connect( robot, obstacles, q, graph.verts(indices(i),:), ceil(10*sortedDists(i))+2 );
            if ( dist>0 )
                nNeighbor = nNeighbor +1;
                graph.vectorEdges(end+1,:) = delta;
                
                graph.adjMat(size(graph.verts,1),indices(i)) = dist;
                graph.adjMat(indices(i),size(graph.verts,1)) = dist; % the adjacency matrix adjMat is symmetric
               
                graph.adjMat4Edges(size(graph.verts,1),indices(i)) = +size(graph.vectorEdges,1); 
                graph.adjMat4Edges(indices(i),size(graph.verts,1)) = -size(graph.vectorEdges,1);   % the adjacency matrix adjMat4Edges is antisymmetric
                
            end
        else
            break;
        end
    end
    