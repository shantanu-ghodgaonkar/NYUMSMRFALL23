%I9_3   Variables initialization for Problem 9.3.

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

% impedance controller gains
  K_d = 1600*diag([1 1]);
  K_p = 5000*diag([1 1]);
  M_d = 100*diag([1 1]);
  iM_d = inv(M_d);

% constraint frame matrix
  R_c = [cos(pi/4)  -sin(pi/4);
        sin(pi/4)  cos(pi/4)];

% stiffness matrix in base frame
  K = R_c*[0 0;0 5e3]*R_c';

% position of undeformed plane
  o_r = [1;0];

% initial position
  p_i = [1+0.2*cos(pi/4); 0];

% final position
  p_f = [1.2+0.2*cos(pi/4);0.2];

% initial joint configuration
  q_i = inv_k2u(a,p_i);

% duration of simulation
  t_d = 2.5;

% trajectory in base frame
  tra_5;

% sample time for plots
  Ts = Tc;