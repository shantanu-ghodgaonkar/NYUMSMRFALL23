%I10_4  Variables initialization for Problem 10.4.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% closed-loop gain
  k_s = 160;

% initial estimate of object position with respect to camera
  xh0 = [0; 0; 0.5; 0];

% feature vector
  s = [-0.1667; 0.1667; -0.0833; 0.0223];

% integration time
  Tc = 0.001;
 
% duration of simulation
  t_d = 40*Tc;

% sample time for plots
  Ts = Tc;