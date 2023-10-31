function dist = distCirclePolygon(b1, b2)

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ~( strncmp(b1.type, 'circle', 5) && strncmp(b2.type, 'polygon', 7) )
    error('inputs error')
end

c1 = b1.pointArray(1,:);

nPoints = b2.nPoints;
pointArray = [ b2.pointArray ; b2.pointArray(1,:) ];

d = zeros(1,nPoints);
for i=1:nPoints
    line = pointArray(i:i+1,:);
    d(i) = distPtLineSeg( c1, line ) - b1.radius;
    if d(i) == 0.0
        dist = 0;
        return;
    end
end

dist = min(d);