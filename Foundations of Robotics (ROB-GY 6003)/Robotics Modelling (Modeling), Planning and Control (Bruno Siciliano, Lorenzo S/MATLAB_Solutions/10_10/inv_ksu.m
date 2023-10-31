function q = inv_ksu(a,x)
%INV_KSu Inverse kinematics for SCARA manipulator in elbow-up posture.
%        q = INV_K2U(a,x) returns vector of joint positions, where:
%
%        a is vector of link lengths
%        x is vector of tip coordinates

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

r = x(1:2)'*x(1:2);
c2 = 0.5*(r - a(1)^2 - a(2)^2)/(a(1)*a(2));
s2 = -sqrt(1 - c2^2);
q(2) = atan2(s2,c2);

k1 = a(1) + a(2)*c2;
k2 = a(2)*s2;

q(1) = atan2(x(1:2)'*[-k2;k1]/r, x(1:2)'*[k1;k2]/r);
q(3) = x(3);
q(4) = x(4) - q(1) - q(2);
