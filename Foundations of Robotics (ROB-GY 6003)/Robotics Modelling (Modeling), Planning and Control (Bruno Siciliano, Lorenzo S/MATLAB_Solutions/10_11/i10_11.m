%I10_11  Variables initialization for Problem 10.11.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global a zc

% load manipulator parameters
  param;

% sample time of controller
  Tc = 0.04;

% controller gains
  K = eye(4);

% initial robot position  
  x_i = [1; 1; 0.5; pi/4]; 
  
% initial joint configuration
  q_i = inv_ksu(a,x_i);

% initial object position
  x_o = [1; 1; 1; pi/4]; 
    
% desired relative position in current camera frame
  x_do = [-0.1; 0.1; 0.6; -pi/3];

% estimated zc
  zc = x_do(3)*[1;1];

% duration of simulation
  t_d = 8;

% sample time for plots
  Ts = Tc;