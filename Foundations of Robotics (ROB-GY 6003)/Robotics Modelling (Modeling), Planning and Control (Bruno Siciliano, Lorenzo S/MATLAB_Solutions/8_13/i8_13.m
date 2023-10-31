%I8_13  Variables initialization for Problem 8.13.

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
  K_d = 16*diag([1 1]);
  K_p = 100*diag([1 1]);

  B_h = diag([a(1)*pi_l(1) + pi_l(2) + a(2) + pi_l(4);
             a(2)*pi_l(3) + pi_l(4) + k_r2*k_r2*pi_l(5)]);

  D  = [zeros(2,2);eye(2,2)];
  H = [D';-K_p -K_d];
  Q = lyap2(H',eye(4,4));

  DQ = D'*Q;
  rho = 70;
  ep = 0.001;

% duration of simulation
  t_d = 2.5;

% trajectory generation
  tra_4;

% sample time for plots
  Ts = Tc;
