%I3_21  Variables initialization for Problem 3.21.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global a r po

% link lengths
  a = [0.5; 0.3; 0.3];

% obstacle parameters
  r = 0.1;
  po = [0.3;0];
  
% closed-loop matrix gain
  K_p = diag([500,500]);

% constraint gain
  k_a = 0;      % unconstrained case
  if c==1,
     k_a = 35;  % constrained case
  end

% gradient step
  Dq = 1e-6;

% initial position
  p_i = [0.8;0.2];

% initial orientation
  phi_i = pi/4;

% final position
  p_f = [0.8;-0.2];

% initial joint position vector
  q_i = inv_k3u(a,[p_i;phi_i]);

% integration time
  Tc = 0.001;

% final time
  t_f = 2;

% duration of simulation
  t_d = 2.5;

% trajectory generation
  % time base vectors
    T_1 = (0:Tc:t_f)';         % first t_f sec
    T_2 = (t_f+Tc:Tc:t_d)';    % last t_d - t_f sec
    T   = [T_1;T_2];           % whole time base vector

  % raised cosine time law of t_f sec duration from 0 to 1
    s = 0.5*(1 - cos((pi/t_f)*T_1));
    ds = 0.5*(pi/t_f)*sin((pi/t_f)*T_1);

  % tip trajectory for the first t_f sec
    p_d1 = ones(size(s))*p_i' + s*(p_f-p_i)';
    dp_d1 = ds*(p_f-p_i)';

  % tip trajectory for the last t_f - t_d sec
    p_d2  = ones(size(T_2))*p_f';
    dp_d2 = zeros(size(T_2,1),2);

  % whole trajectory
    p_d = [p_d1;p_d2];
    dp_d = [dp_d1;dp_d2];

% sample time for plots
  Ts = Tc;
  
clear T_1 T_2 s ds p_d1 p_d2 dp_d1 dp_d2
