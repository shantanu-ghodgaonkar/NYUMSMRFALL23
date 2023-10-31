%I10_8  Variables initialization for Problem 10.8.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global a k_r1 k_r2 pi_m pi_l m3 I4

% dynamic parameters of SCARA manipulator 
  param;
  pi_l = pi_m;
  m3 = 2;
  I4 = 1;

% gravity acceleration
  g = 9.81;

% friction matrix
  K_r = diag([k_r1 k_r2 1 1]);
  F_v = K_r*diag([0.01 0.01 0 0])*K_r;

% sample time of controller
  Tc = 0.04;

% controller gains
  K_d = diag([500 500 10 10]);
  K_p = diag([500 500 10 10]);

% initial robot position  
  x_i = [1; 1; 0.5; pi/4]; 
  
% initial joint configuration
  q_i = inv_ksu(a,x_i);

% initial object position
  x_o = [1; 1; 1; pi/4]; 
    
% desired relative position in current camera frame
  x_do = [-0.1; 0.1; 0.6; -pi/3];

% parameters of estimation algorithm
  Te = 0.001;
  k_s = 160;
  xh0 = x_do;

% duration of simulation
  t_d = 8;

% sample time for plots
  Ts = Tc;