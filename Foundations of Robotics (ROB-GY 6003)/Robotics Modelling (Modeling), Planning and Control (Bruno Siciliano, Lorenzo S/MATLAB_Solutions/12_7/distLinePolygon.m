function dist = distLinePolygon(b1, b2)

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ~( strncmp(b1.type, 'line', 4) && strncmp(b2.type, 'polygon', 7) )
    error('inputs error')
end


l1=b1.pointArray;

nPoints = b2.nPoints;
d = zeros(1,nPoints);

for i=1:(nPoints-1)
    line = b2.pointArray(i:i+1,:);
    d(i) = distLineSegLineSeg(l1 , line );
end

line = [ b2.pointArray(nPoints,:) ; b2.pointArray(1,:) ];
d(nPoints) = distLineSegLineSeg( l1, line );

dist = min(d);