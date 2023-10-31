function h = drawBody( body, style, faceColor )
% inputs:
% body = a body structure created with the functions createLineSeg(),createCircle(), createPolygon()
% style = style(1) defines the color of the edges of the body, style(2:end) the line style of the edges of the body
% faceColor = the color of the robot

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ( nargin == 1 )
        style = 'b-';
        faceColor = 'none';
elseif ( nargin == 2 )
        faceColor = 'none';
end


switch body.type
   case 'circle'
      h = drawCircle(body, style, faceColor);
   case 'line'
      h = drawLineSeg(body, style);
   case 'polygon'
      h = drawPolygon(body, style, faceColor);
   otherwise
      error('Unknown body')
end
