function Jsa = Js_a(u)
%JSA    Analytic Jacobian for SCARA manipulator.
%       Jsa = Js_a(u) returns 4-by-4 analytic Jacobian, where:
%
%       u=[a(1)*c_1;a(2)*c_12;a(1)*s_1;a(2)*s_12]

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

Jsa = eye(4);
Jsa(:,2) = [-u(4); u(2); 0; 1];
Jsa(:,1) = [-u(3); u(1); 0; 0] + Jsa(:,2);
