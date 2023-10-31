function dist = distPolygonPolygon(b1, b2)

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ~( strncmp(b1.type, 'polygon', 7) && strncmp(b2.type, 'polygon', 7) )
    error('inputs error')
end

n1Points = b1.nPoints;
n2Points = b2.nPoints;

pointArray1 = [ b1.pointArray ; b1.pointArray(1,:) ];
pointArray2 = [ b2.pointArray ; b2.pointArray(1,:) ];

d = zeros(n1Points,n2Points);

for i1=1:n1Points
    line1 = pointArray1(i1:i1+1,:);
    for i2=1:n2Points
        line2 = pointArray2(i2:i2+1,:);
        d(i1,i2) = distLineSegLineSeg(line1 , line2 );
        if d(i1,i2) == 0.0
            dist = 0;
            return;
        end
    end
end
dist = min(d);