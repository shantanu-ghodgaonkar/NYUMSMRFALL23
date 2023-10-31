function h = drawRobot( robot ,style, faceColor )
% inputs:
% robot = a robot structure created with the function createRobot()
% style = style(1) defines the color of the edges, style(2:end) the line style of the edges
% faceColor = the color of the robot

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ( nargin == 1 )
        style = 'b-';
        faceColor = 'none';
elseif ( nargin == 2 )
        faceColor = 'none';
end


nLinks=robot.nLinks;
for i = 1:nLinks
    nLinkBodies = robot.positionedLinkArray{i}.nBodies;
    for j=1:nLinkBodies
        drawBody(robot.positionedLinkArray{i}.bodyArray{j}, style, faceColor);
    end

end
