%I8_10  Variables initialization for Problem 8.10.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global a k_r1 k_r2 pi_m pi_l

% load manipulator dynamic parameters without load mass
  param;
  pi_l = pi_m;

% gravity acceleration
  g = 9.81;

% friction matrix
  K_r = diag([k_r1 k_r2]);
  F_v = K_r*diag([0.01 0.01])*K_r;

% sample time of controller
  Tc = 0.001;

% controller gains
  K_d = 750*diag([1 1]);
  K_p = 3750*diag([1 1]);

% desired position
  if c==0,
     q_d = [pi/4; -pi/2];
       else
     q_d = [-pi; -3*pi/4];
  end

% initial position
  q_i = q_d - 0.1;

% duration of simulation
  t_d = 2.5;

% sample time for plots
  Ts = Tc;


