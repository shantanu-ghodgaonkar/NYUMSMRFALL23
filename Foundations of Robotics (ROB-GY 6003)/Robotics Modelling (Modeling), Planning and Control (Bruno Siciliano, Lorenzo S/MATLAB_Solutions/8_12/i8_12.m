%I6_12  Variables initialization for Problem 8.12.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global a k_r1 k_r2 pi_m pi_l

% load manipulator dynamic parameters without load mass
  param;
  load_m;

if c==1,
   % compensated load mass
     pi_m = pi_l;
end;

% gravity acceleration
  g = 9.81;

% friction matrix
  K_r = diag([k_r1 k_r2]);
  F_v = K_r*diag([0.01 0.01])*K_r;

% sample time of controller
  Tc = 0.001;

% controller gains
  K_d = 16*diag([1 1]);
  K_p = 100*diag([1 1]);

% duration of simulation
  t_d = 2.5;

% trajectory generation
  tra_4;

% sample time for plots
  Ts = Tc;


