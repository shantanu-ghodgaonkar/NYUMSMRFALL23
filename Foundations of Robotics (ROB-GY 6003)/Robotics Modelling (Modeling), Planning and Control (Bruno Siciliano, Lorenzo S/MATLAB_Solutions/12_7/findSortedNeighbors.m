function [sortedDists, indexArray] = findSortedNeighbors( verts, sampleq , jointLimits)
% find the distance between sampleq and all configurations in graph.verts 

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

N = size(verts,1);
nodeDists = zeros(1,N); 

for i = 1:N
    nodeDists(i) = distCspace( sampleq, verts(i,:), jointLimits );
end

% sort the dists
[sortedDists, indexArray] = sort( nodeDists );