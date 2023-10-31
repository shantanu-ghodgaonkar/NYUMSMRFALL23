function dq = trJ_a(w)
%TRJ_A  Joint velocity with Jacobian transpose for two-link planar arm.
%       dq = TRJ_A(w) returns vector of joint velocities as:
%
%       dq = J_a(w(3:6))'*w(1:2)
%
%       where:
%
%       w(3:6)=[a(1)*c_1;a(2)*c_12;a(1)*s_1;a(2)*s_12]

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

dq = J_a(w(3:6))'*w(1:2);
