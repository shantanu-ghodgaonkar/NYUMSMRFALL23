function dq = invJ_aq(w)
%INVJ_AQ Joint velocity with Jacobian transpose for SCARA manipulator.
%        dq = INVJ_AQ(w) returns vector of joint velocities as:
%
%       dq = inv(J_aq(w(5:14)))*w(1:4)
%
%       where:
%
%       w(5:8)=[a(1)*c_1;a(2)*c_12;a(1)*s_1;a(2)*s_12]
%       w(10)  =q1+q2+q4 = phi_c
%       w(14) = phi_d - phi_c 

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

dq = inv(J_aq(w(5:14)))*w(1:4);
