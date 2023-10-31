function q = inv_k2u(a,x)
%INV_K2U Inverse kinematics for two-link planar arm in elbow-up posture.
%        q = INV_K2U(a,x) returns vector of joint positions, where:
%
%        a is vector of link lengths
%        x is vector of tip coordinates

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

r = x'*x;
c2 = 0.5*(r - a(1)^2 - a(2)^2)/(a(1)*a(2));
s2 = -sqrt(1 - c2^2);
q(2) = atan2(s2,c2);

k1 = a(1) + a(2)*c2;
k2 = a(2)*s2;

q(1) = atan2(x'*[-k2;k1]/r, x'*[k1;k2]/r);
