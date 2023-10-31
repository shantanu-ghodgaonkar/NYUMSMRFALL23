function h = drawLineSeg( l, style )

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ( nargin == 1 )

        % default settings
        color = 'b';
        lineStyle = '-';    
        
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
    
end

x=l.pointArray(:,1)';
y=l.pointArray(:,2)';
h=line(x,y,'color',color,'lineStyle',lineStyle);