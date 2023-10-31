function circle = createCircle( center, radius )
% create a circle structure
% inputs:
% center = [x1 , y1]
% radius 

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

circle.pointArray = center;
circle.nPoints=1;
circle.type = 'circle';

circle.radius = radius;

circle.boundingBox = [(center(1)-radius), (center(2)-radius);
                      (center(1)+radius), (center(2)+radius)]; 
