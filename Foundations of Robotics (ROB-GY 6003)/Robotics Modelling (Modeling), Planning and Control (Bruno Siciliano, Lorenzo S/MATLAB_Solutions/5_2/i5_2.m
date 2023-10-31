%I5_2   Variables initialization for Problem 5.2.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% motor parameters
  I_m = 0.0014;
  F_m = 0.01;
  L_a = 2e-3;
  R_a = 0.2;
  k_t = 0.2;
  k_v = 0.2;
  G_v = 1;
  T_v = 0.1e-3;

% controller parameters
  C_i = 1;

% integration time
  Tc = 0.0001;

% duration of simulation
  t_d = 0.15;

% sample time for plots
  Ts = 0.001;
