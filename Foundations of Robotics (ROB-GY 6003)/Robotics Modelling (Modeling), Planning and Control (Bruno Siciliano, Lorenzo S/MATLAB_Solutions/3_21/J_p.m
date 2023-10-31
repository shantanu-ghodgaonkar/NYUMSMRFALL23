function Jp = J_p(u)
%J_P    Positional Jacobian for three-link planar arm.
%       Jp = J_P(u) returns 2-by-3 positional Jacobian, where:
%
%       u=[a(1)*c_1;a(2)*c_12;a(3)*c_123;a(1)*s_1;a(2)*s_12;a(3)*s_123]

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

Jp = zeros(2,3);

Jp(1:2,3) = [-u(6); u(3)];
Jp(1:2,2) = [-u(5); u(2)] + Jp(1:2,3);
Jp(1:2,1) = [-u(4); u(1)] + Jp(1:2,2);
