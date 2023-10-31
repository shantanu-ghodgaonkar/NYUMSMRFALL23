function h = drawCircle( circle, style ,faceColor)
% inputs:
% circle = a circle structure created with the function createCircle()
% style = style(1) defines the color of the edges, style(2:end) the line style of the edges
% faceColor = the color of the circle

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

N = 30;

center = circle.pointArray;
radius = circle.radius;

t=(1/N)*(0:2*pi:2*pi*N);
x=center(1)+radius*cos(t);
y=center(2)+radius*sin(t);
pointArray = [x' y'];

fac = 1:size(pointArray,1);
h = patch('Faces',fac,'Vertices',pointArray,'EdgeColor',color,'LineStyle',lineStyle,'FaceColor',faceColor);

