%I3_22  Variables initialization for Problem 3.22.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% link lengths
  a = [0.5; 0.5];

% closed-loop matrix gain
  K = diag([500,500,500,100]);

% initial position and orientation
  x_i = [0.7;0;0;0];

% final position and orientation
  x_f = [0;0.8;0.5;0.5*pi];

% initial joint position vector
  q_i = zeros(1,4);
  q_i(1:2) = inv_k2u(a,x_i(1:2));
  q_i(3)= x_i(3);
  q_i(4)= x_i(4) - q_i(1) - q_i(2);

% integration time
  Tc = 0.001;

% final time
  t_f = 2;

% duration of simulation
  t_d = 2.5;

% trajectory generation
  % time base vectors
    T_1 = (0:Tc:t_f)';         % first t_f sec
    T_2 = (t_f+Tc:Tc:t_d)';    % last t_d - t_d sec
    T   = [T_1;T_2];           % whole time base vector

  % raised cosine time law of t_f sec duration
    s = 0.5*(1 - cos((pi/t_f)*T_1));
    ds = 0.5*(pi/t_f)*sin((pi/t_f)*T_1);

  % tip trajectory for the first t_f sec
    x_d1 = ones(size(s))*x_i' + s*(x_f - x_i)';
    dx_d1 = ds*(x_f - x_i)';

  % tip trajectory for the last t_d - t_f sec
    x_d2  = ones(size(T_2))*x_f';
    dx_d2 = zeros(size(T_2,1),4);

  % whole trajectory
    x_d = [x_d1;x_d2];
    dx_d = [dx_d1;dx_d2];

% sample time for plots
  Ts = Tc;

clear T_1 T_2 s ds x_d1 x_d2 dx_d1 dx_d2
