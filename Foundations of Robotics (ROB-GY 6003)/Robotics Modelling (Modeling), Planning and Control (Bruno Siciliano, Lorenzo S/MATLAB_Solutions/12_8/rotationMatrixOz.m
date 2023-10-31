function mat = rotationMatrixOz(theta)
%return a 3x3 rotation matrix around z-axis

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

ct = cos(theta);
st = sin(theta);

mat=[ ct -st 0;...
      st  ct 0;...
       0  0  1];

