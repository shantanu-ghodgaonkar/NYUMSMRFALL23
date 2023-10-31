function dist = distCircleCircle(b1, b2)

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ~( strncmp(b1.type, 'circle', 5) && strncmp(b2.type, 'circle', 5) )
    error('inputs are not circles')
end

r1 = b1.radius;
r2 = b2.radius;

c1 = b1.pointArray(1,:);
c2 = b2.pointArray(1,:);

dist = norm(c1-c2) - (r1+r2);