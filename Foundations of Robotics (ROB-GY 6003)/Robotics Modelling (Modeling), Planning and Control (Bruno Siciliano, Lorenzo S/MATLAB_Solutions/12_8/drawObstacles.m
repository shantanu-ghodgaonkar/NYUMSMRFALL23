function h = drawObstacles( obstacleArray , style, faceColor )
% inputs:
% obstacles = an array of body structures created with the functions createLineSeg(),createCircle(), createPolygon()
% style = style(1) defines the color of the obstacle edges, style(2:end) the line style of the obstacle edges
% faceColor = the color of the robot

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ( nargin == 1 )
        style = 'b-';
        faceColor = 'none';
elseif ( nargin == 2 )
        faceColor = 'none';
end

nBodies=length( obstacleArray);
for i = 1:nBodies
    drawBody( obstacleArray{i}, style, faceColor );
end

