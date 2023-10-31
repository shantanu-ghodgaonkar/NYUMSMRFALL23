%I8_15  Variables initialization for Problem 8.15.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global a k_r1 k_r2 pi_m pi_l

% load manipulator dynamic parameters with load mass
  param;
  load_m;
  pi_m = pi_l;

% gravity acceleration
  g = 9.81;

% friction matrix
  K_r = diag([k_r1 k_r2]);
  F_v = K_r*diag([0.01 0.01])*K_r;

% sample time of controller
  Tc = 0.001;

% controller gains
  K_d = 3250*diag([1 1]);
  K_p = 16250*diag([1 1]);

% desired position
  if c==0,
     p_d = [0.5; 0.5];
       else
     p_d = [0.6; -0.2];
  end

% initial position
  p_i = p_d - 0.1;

% initial joint configuration
  q_i = inv_k2u(a,p_i);

% duration of simulation
  t_d = 2.5;

% sample time for plots
  Ts = Tc;


