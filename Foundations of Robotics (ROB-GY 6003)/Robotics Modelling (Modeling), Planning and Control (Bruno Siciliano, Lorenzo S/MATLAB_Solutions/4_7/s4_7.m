%s4_7   Solution to Problem 4.7.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all

% initial and final time
  t = [0;2];

% initial position
  p_i = [0;0.5;0];

% final position
  p_f = [1;-0.5;0];

% sample time
  Ts = 0.01;

% maximum velocity of path coordinate
  ds_c = 1;

% segment length
  D_s = norm(p_f - p_i);

% trapezoidal velocity profile trajectory for path coordinate from 0 to 1
  [time,s,ds,dds,err] = trapez(0,1,ds_c/D_s,t(2)-t(1),Ts);

% trajectory generation
  p = ones(size(time))*p_i' + s*(p_f - p_i)';
  dp = ds*(p_f - p_i)';
  ddp = dds*(p_f - p_i)';

% plot
  p4_7;
