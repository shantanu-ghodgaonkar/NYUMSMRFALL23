function dm = d_min(u)
%D_MIN  Distance of three-link planar arm from circular obstacle.
%       dm = D_MIN(u) returns minimum distance for a three-link planar arm
%       where:
%
%       u=[a(1)*c_1;a(2)*c_12;a(3)*c_123;a(1)*s_1;a(2)*s_12;a(3)*s_123]

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global a r po

% splits the 1-by-6 vector u in a 2-by-3 matrix
  Pr = [u(1) u(2) u(3); u(4) u(5) u(6)];

% evaluates matrix R_o = [p_0-p_o;p_1-p_o;p_2-p_o] where
% p_i is the origin of frame i, i=0,1,2
  R_o = [0 u(1) u(1)+u(2);0 u(4) u(4)+u(5)] - po*ones(1,3);

% evaluates vector s_opt of x-coordinates of minimum distance point
% along line of each link
  s_opt = - (R_o(1,:).*Pr(1,:) + R_o(2,:).*Pr(2,:))'./(a.*a);

% evaluates vector sm of x-coordinates of minimum distance point on link
  sm = max(min(s_opt,1),0);

% evaluates minimum distace dm
  dm = min(sqrt((R_o(1,:)+sm'.*Pr(1,:)).^2 + (R_o(2,:)+sm'.*Pr(2,:)).^2) - r);
