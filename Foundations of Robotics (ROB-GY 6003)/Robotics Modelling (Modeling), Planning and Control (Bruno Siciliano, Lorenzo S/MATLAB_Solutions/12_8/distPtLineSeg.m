function [dist, closestPt] = distPtLineSeg( pt, line )
% Author: 
% inspired by the function made by Prof. David Johnson
% http://www.eng.utah.edu/~cs6370/Assignment4.html

% computes the minimum distance between a point and a line segment.
% Outputs:
%       dist: the distance between the point and the segment
%       closestpt : the point on the line seg which is closest to pt

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% Create the vector to project onto the line segment
ptvec = pt - line(1,:);

% Turn the line segment into a vector
linevec = line(2,:) - line(1,:);

linevec_length_squared = dot( linevec, linevec );

% test for degenerate line seg
if ( linevec_length_squared < 0.0000001 )
    dist = norm( pt - line(1,:) );
    closestPt = line(1,:);
    return;
end

% Get a vector to result in a 0-1 projection range
projvec = linevec / dot( linevec, linevec );

% Get the projection
proj = dot(ptvec, projvec);

% Test for end cases and then the body of the segment
if proj < 0.0
    closestPt = line(1,:);
elseif proj > 1.0
    closestPt = line(2,:);
else
    closestPt = line(1,:) + proj * linevec;
end

% Compute the norm
dist = norm( pt - closestPt );

