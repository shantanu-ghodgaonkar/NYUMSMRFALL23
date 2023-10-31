function h = drawPolygon( polygon, style , faceColor)
% inputs:
% polygon = a polygon structure created with the function createPolygon()
% style = style(1) defines the color of the edges, style(2:end) the line style of the edges
% faceColor = the color of the polygon

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ( nargin == 1 )
    
        % default settings
        color = 'b';
        lineStyle = '-';    
        faceColor = 'none';
        
elseif ( nargin == 2 )
    
    if isempty(style)
        color = 'b';
        lineStyle = '-';    
    elseif length(style) == 1
        color = style;
        lineStyle = '-';
    else
        color = style(1);
        lineStyle = style(2:end);
    end
    faceColor = 'none';
    
elseif ( nargin == 3 )
    
    if isempty(style)
        color = 'b';
        lineStyle = '-'; 
    elseif length(style) == 1
        color = style;
        lineStyle = '-';
    else
        color = style(1);
        lineStyle = style(2:end);
    end
    
    if isempty(faceColor)
        faceColor = 'none';
    end
    
end

fac = 1:polygon.nPoints;
h = patch('Faces',fac,'Vertices',polygon.pointArray,'EdgeColor',color,'LineStyle',lineStyle,'FaceColor',faceColor);