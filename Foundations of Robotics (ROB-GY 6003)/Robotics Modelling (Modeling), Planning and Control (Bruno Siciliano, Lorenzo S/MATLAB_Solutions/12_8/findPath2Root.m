function  path = findPath2Root (nodeIndex , RRT)
% inputs:
% nodeIndex = the index of a node of RRT.verts
% RRT = a tree built by the function buildRRT
%
% outputs:
% path = a sequence of configurations [q1;q2;...;qm]

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

nVertices = size(RRT.verts,1);

path = [];
pathIndices = [nodeIndex ]; % sequence of node indices from RRT.verts(nodeIndex) to RRT.verts(1)
lastNodeIndex = nodeIndex; 

while (lastNodeIndex ~= 1)

    for i=1:nVertices
        if (RRT.adjMat(lastNodeIndex,i)<0) %  RRT.adjMat(lastNodeIndex,i) == -1 -> RRT.verts(i) is the parent of lastNodeIndex
            
            pathIndices = [i pathIndices];
            
            e = RRT.adjMat4Edges(i,lastNodeIndex);
            path = [RRT.vectorEdges{abs(e)}; path];
            
            lastNodeIndex = i;
            break;
        end
    end
 
end





    
    
