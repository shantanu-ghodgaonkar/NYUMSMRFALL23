%s4_5   Solution to Problem 4.5.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all

% time instants
  t = [0;1;2;3;4];

% initial position, velocity and acceleration vector
  q_i = [0;0;0];

% final position, velocity and acceleration vector
  q_f = [3;0;0];

% intermediate position
  q_m = 2;

% sample time
  Ts = 0.01;

% trajectory generation
  [time,q,dq,ddq] = spline_c(q_i,q_f,q_m,t,Ts);

% plot
  p4_5;
