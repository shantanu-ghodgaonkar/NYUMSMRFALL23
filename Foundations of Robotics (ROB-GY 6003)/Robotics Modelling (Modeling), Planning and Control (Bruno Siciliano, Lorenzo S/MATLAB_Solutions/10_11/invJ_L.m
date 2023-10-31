function dq = invJ_L(w)
%INVJ_L Joint velocity with image Jacobian transpose for SCARA manipulator,
%       based on line segment features and estimated zc.
%       dq = INVJ_L(w) returns vector of joint velocities as:
%
%       dq = J_L(w(5:14))'*w(1:4)
%
%       where:
%
%       w(1:4) =[a(1)*c_1;a(2)*c_12;a(1)*s_1;a(2)*s_12]
%       w(6)   =q1+q2+q4 = phi_c
%       w(7:10)=s

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global zc

dq = inv(J_L(w(5:14)))*w(1:4);
