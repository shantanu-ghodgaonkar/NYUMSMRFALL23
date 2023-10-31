function y = adap(u)
%ADAP   Adaptive control law.
%       y = ADAP(u) returns control input y(1:2) and
%       derivative y(3) of parameter estimate

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global a k_r2 g pi_m F_v pi_l

dq    = u(1:2);
ddq_r = u(3:4);
dq_r  = u(5:6);
sig   = u(7:8);
c_1   = u(9);
c_2   = u(10);
s_2   = u(11);
c_12  = u(12);
m_l   = u(13);
Y_r = zeros(2,5);

% evaluates complete regressor
  Y_r(1,1) = a(1)*ddq_r(1) + g*c_1;
  Y_r(1,2) = ddq_r(1);
  Y_r(1,4) = ddq_r(1) + ddq_r(2);
  Y_r(1,3) = a(1)*c_2*(ddq_r(1) + Y_r(1,4)) - a(1)*s_2*(dq(2)*dq_r(1) +...
           dq_r(2)*(dq(1) + dq(2))) + a(2)*Y_r(1,4) + g*c_12;
  Y_r(1,5) = k_r2*ddq_r(2);
  Y_r(2,3) = a(2)*Y_r(1,4) + a(1)*c_2*ddq_r(1) + a(1)*s_2*dq(1)*dq_r(1) +...
           g*c_12;
  Y_r(2,4) = Y_r(1,4);
  Y_r(2,5) = k_r2*Y_r(1,5);

% builds load regressor
  Y_l = [a(1)*Y_r(1,1) + a(2)*Y_r(1,3);
         a(1)*Y_r(2,1) + a(2)*Y_r(2,3)];

  dm_l = Y_l'*sig;

  tau =  Y_r*pi_m' + F_v*dq_r + Y_l*m_l;

  y = [tau;dm_l];
