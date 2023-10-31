function pp = poly_5(t,q_i,q_f)
%POLY_5 Coefficients of interpolating quintic polynomial.
%       pp = POLY_5(t,q,dq,ddq) returns vector pp of 6 coefficients of
%       polynomial expressing motion law from q_i(1) at t_i=t(1) to
%       q_f(1) at t_f=t(2) with initial velocity and acceleration
%       q_i(2), q_i(3), and final velocity and acceleration q_f(2), q_f(3),
%       as:
%
%       q(t) = a_5*t^5+a_4*t^4+a_3*t^3+a_2*t^2+a_1*t+a_0
%
%       where:
%
%       a_i = pp(6-i), i=0,...,6

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% builds coefficient matrix A and vector b of linear system obtained
% from boundary conditions

A = zeros(6,6);
for i=1:2
    j = i*i;
    A(j,6) = 1;
    for k=5:-1:1,
        A(j,k) = t(i)*A(j,k+1);
    end
    A(j+1,1:5) = [5*A(j,2) 4*A(j,3) 3*A(j,4) 2*A(j,5) 1];
    A(j+2,1:4) = [20*A(j,3) 12*A(j,4) 6*A(j,5) 2];
end

b = [q_i;q_f];

% solves linear system A*pp=b
  pp = A\b;
