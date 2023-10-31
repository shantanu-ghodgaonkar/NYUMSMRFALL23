function q = inv_k3u(a,x)
%INV_K3U Inverse kinematics for three-link planar arm in elbow-up posture.
%        q = INV_K3U(a,x) returns vector of joint positions, where:
%
%        a is vector of link lengths
%        x is vector of end-effector coordinates (position + orientation)

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% evaluates origin of frame 2 (wrist point)
  p2 = x(1:2) - a(3)*[cos(x(3));sin(x(3))];

r = p2'*p2;
c2 = 0.5*(r - a(1)^2 - a(2)^2)/(a(1)*a(2));
s2 = -sqrt(1 - c2^2);
q(2) = atan2(s2,c2);

k1 = a(1) + a(2)*c2;
k2 = a(2)*s2;

q(1) = atan2(p2'*[-k2;k1]/r, p2'*[k1;k2]/r);

q(3) = x(3) - q(1) - q(2);
