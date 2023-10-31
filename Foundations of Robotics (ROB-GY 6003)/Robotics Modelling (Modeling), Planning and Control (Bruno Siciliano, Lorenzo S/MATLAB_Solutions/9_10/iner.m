function  B = iner(c_2)
%INER   Inertia matrix of two-link planar arm.
%       B = INER(c_2) returns 2-by-2 inertia matrix of two-link planar arm
%       where:
%
%       c_2 = cos(q(2))

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global pi_m a k_r2

B(1,1) = a(1)*pi_m(1) + pi_m(2) + (a(2) + 2*a(1)*c_2)*pi_m(3) + pi_m(4);

B(1,2) = (a(2) + a(1)*c_2)*pi_m(3) + pi_m(4) + k_r2*pi_m(5);

B(2,1) = B(1,2);

B(2,2) = a(2)*pi_m(3) + pi_m(4) + k_r2*k_r2*pi_m(5);
