function y = invJ_a(w)
%INVJ_A Joint velocity with Jacobian inverse for two-link planar arm.
%       y = INVJ_A(w) returns joint velocity as:
%
%       y = inv(J_a(w(3:6))*w(1:2)
%
%       where:
%
%       w(3:6)=[a(1)*c_1;a(2)*c_12;a(1)*s_1;a(2)*s_12]

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

y = inv(J_a(w(3:6)))*w(1:2);
