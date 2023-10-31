function dist = distCircleLine(b1, b2)

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ~( strncmp(b1.type, 'circle', 5) && strncmp(b2.type, 'line', 4) )
    error('inputs error')
end

c1 = b1.pointArray(1,:);
 l = b2.pointArray;

dist = distPtLineSeg( c1, l ) - b1.radius;