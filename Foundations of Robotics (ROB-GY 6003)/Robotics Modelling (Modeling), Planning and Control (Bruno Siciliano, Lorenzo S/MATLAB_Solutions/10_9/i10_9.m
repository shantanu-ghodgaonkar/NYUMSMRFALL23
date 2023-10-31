%I10_9  Variables initialization for Problem 10.9.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global a

% load manipulator parameters
  param;

% sample time of controller
  Tc = 0.04;

% controller gains
  K = eye(4);
  K(4,4) = 2;

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