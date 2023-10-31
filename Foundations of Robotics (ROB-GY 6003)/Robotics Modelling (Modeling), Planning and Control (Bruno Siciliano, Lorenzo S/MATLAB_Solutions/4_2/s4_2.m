%s4_2   Solution to Problem 4.2.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all

% initial and final time
  t = [0;2];

% initial position, velocity and acceleration vector
  q_i = [0;0;0];

% final position, velocity and acceleration vector
  q_f = [3;0;0];

% sample time
  Ts = 0.01;

% time base vector
  time = t(1):Ts:t(2);

% trajectory parameters
  a = 2*pi/t(2);
  k = (q_f(1)-q_i(1))/t(2);

% position
  s = sin(a*time);
  q = q_i(1) + k*(time - (1/a)*s);

% velocity
  dq = k*(1 - cos(a*time));

% acceleration
  ddq = a*k*s;

% plot
  p4_2
