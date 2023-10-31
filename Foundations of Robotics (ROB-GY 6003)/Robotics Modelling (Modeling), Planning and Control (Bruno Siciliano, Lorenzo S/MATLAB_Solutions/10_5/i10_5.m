%I10_5  Variables initialization for Problem 10.5.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% closed-loop gain
  k_s = 160;

% initial estimate of object position with respect to camera
  xh0 = [0; 0; 0.5; 0];

% feature vector
  sp0 = [-0.1667; 0.1667; -0.0833; 0.0223];
  s  = features_l(sp0);

% integration time
  Tc = 0.001;
 
% duration of simulation
  t_d = 40*Tc;

% sample time for plots
  Ts = Tc;