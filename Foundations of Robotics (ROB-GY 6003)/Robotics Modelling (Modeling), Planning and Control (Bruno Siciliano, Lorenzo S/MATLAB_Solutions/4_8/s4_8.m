%s4_8   Solution to Problem 4.8.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all

% initial and final time
  t = [0;2];

% initial position
  p_i = [0;0.5;1];

% final position
  p_f = [0;-0.5;1]; 

% sample time
  Ts = 0.01;

% center
  c = [0;0;1];

% radius
  rho = 0.5;

% final value of path coordinate
  s_f = pi/2;

% maximum velocity of path coordinate
  ds_c = 1;

% trapezoidal velocity profile trajectory for path coordinate from 0 to s_f
  [time,s,ds,dds,err] = trapez(0,s_f,ds_c,t(2)-t(1),Ts);

% trajectory generation
  p = zeros(size(time,1),3);
  dp = p;
  ddp = p;
  sn = s/rho;
  cos_sn = cos(sn);
  sin_sn = sin(sn);
  p(:,2:3) = ones(size(time))*c(2:3)' + rho*[cos_sn -sin_sn];
  dp(:,2:3) = [-ds.*sin_sn  -ds.*cos_sn];
  ddp(:,2:3) = [ds.*dp(:,3)  -ds.*dp(:,2)] + [dds.*dp(:,2)  dds.*dp(:,3)];

% plot
  p4_8;
