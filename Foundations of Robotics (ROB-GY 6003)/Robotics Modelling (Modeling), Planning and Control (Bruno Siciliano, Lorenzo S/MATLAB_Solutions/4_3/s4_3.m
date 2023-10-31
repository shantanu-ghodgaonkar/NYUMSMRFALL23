%s4_3   Solution to Problem 4.3.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all

% time instants
  t = [0;2;4];

% initial position, velocity and acceleration vector
  q_i = [0;0;0];

% intermediate position, velocity and acceleration vector
  q_m = [2;0;0];

% final position, velocity and acceleration vector
  q_f = [3;0;0];

% intermediate velocity
  dq_m1 = (q_m(1) - q_i(1))/(t(2) - t(1));
  dq_m2 = (q_f(1) - q_m(1))/(t(3) - t(2));
  q_m(2) = (dq_m1 + dq_m2)/2;

% intermediate acceleration
  ddq_m1 = (q_m(2) - q_i(2))/(t(2) - t(1));
  ddq_m2 = (q_f(2) - q_m(1))/(t(3) - t(2));
  q_m(3) = (ddq_m1 + ddq_m2)/2;

% coefficients of first trajectory
  pp_1 = poly_5(t(1:2),q_i,q_m);
  dpp_1 = polyder(pp_1);
  ddpp_1 = polyder(dpp_1);

% coefficients of second trajectory
  pp_2 = poly_5(t(2:3),q_m,q_f);
  dpp_2 = polyder(pp_2);
  ddpp_2 = polyder(dpp_2);

% sample time
  Ts = 0.01;

% first trajectory

  % time base vector
    time_1 = t(1):Ts:t(2);

  % position
    q_1 = polyval(pp_1,time_1);

  % velocity
    dq_1 = polyval(dpp_1,time_1);

  % acceleration
    ddq_1 = polyval(ddpp_1,time_1);

% second trajectory

  % time base vector
    time_2 = t(2):Ts:t(3);

  % position
    q_2 = polyval(pp_2,time_2);

  % velocity
    dq_2 = polyval(dpp_2,time_2);

  % acceleration
    ddq_2 = polyval(ddpp_2,time_2);

% plot
  p4_3
