function H = drawCspaceProjX1Y1Q1Line( path , style)
% draw a line in the C-space projection [x1 y1 q1]
% outputs:
% H = the vector of line handles

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
 
x1=path(:,1)';
y1=path(:,2)';
q1=wrap(path(:,3)');

L = length(q1);

% initialize the array of line indices; one has a distinct line from lineIndices(i) to lineIndices(i+1)
lineIndices = 1; 

% find indices where q1 jumps more than 2*pi
threshold = 0.2;
for i=1:(L-1)
    if abs( q1(i+1) - q1(i)) >= (2*pi-threshold)
        lineIndices= [lineIndices i]; 
    end
end

lineIndices= [lineIndices L]; % add the last index

% draw the lines
H = [];
for j=1:(length(lineIndices)-1)
    s = lineIndices(j);
    e = lineIndices(j+1);
    lineIndices(j+1) = lineIndices(j+1)+1;
    h = line(x1(s:e),y1(s:e),q1(s:e),'color',color,'lineStyle',lineStyle);
    H = [h H];
    if (e > 1) && (e < L)
        plot3(x1(e),y1(e),q1(e),'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',3);
        plot3(x1(e+1),y1(e+1),q1(e+1),'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',3);
    end
end

