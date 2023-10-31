function  B = iner_s(c_2);
%INER_S Inertia matrix of SCARA manipulator.
%       B = INER_S(c_2) returns 4-by-4 inertia matrix of SCARA manipulator %
%       where:
%
%       c_2 = cos(q(2))

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global pi_l a k_r2 m3 I4

B(1,1) = a(1)*pi_l(1) + pi_l(2) + (a(2) + 2*a(1)*c_2)*pi_l(3) + pi_l(4) + I4 + (a(1)^2 + a(2)^2 + 2*a(1)*a(2)*c_2)*m3;

B(1,2) = (a(2) + a(1)*c_2)*pi_l(3) + pi_l(4) + k_r2*pi_l(5) + (a(2)^2 + a(1)*a(2)*c_2)*m3;

B(1,3) = 0;

B(1,4) = I4;

B(2,1) = B(1,2);

B(2,2) = a(2)*pi_l(3) + pi_l(4) + k_r2*k_r2*pi_l(5) + I4 + m3*a(2)^2;

B(2,3) = 0;

B(2,4) = I4;

B(3,1) = B(1,3);

B(3,2) = B(2,3);

B(3,3) = m3;

B(3,4) = 0;

B(4,1) = B(1,4);

B(4,2) = B(2,4);

B(4,3) = B(3,4);

B(4,4) = I4;