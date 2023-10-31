%I8_16  Variables initialization for Problem 8.16.

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

% initial position
  p_i = [0.7; 0.2];

% initial joint configuration
  q_i = inv_k2u(a,p_i);

% final position
  p_f = [0.1;-0.6];

% duration of simulation
  t_d = 2.5;

% trajectory generation
  % time base vector
    T = (0:Tc:t_d)';

  % segment length
    D_s = norm(p_f - p_i);

  % trapezoidal velocity profile trajectory for path coordinate from 0 to 1
    ds_c = 1.5;                % maximum velocity
    t_f  = 1;                  % final time
    [T_1,s,ds,dds,err] = trapez(0,1,ds_c/D_s,t_f,Tc);

    n = size(T,1);
    m = size(T_1,1);
    p_d = zeros(n,2);
    dp_d = p_d;
    ddp_d = p_d;

  % tip trajectory
    p_d(1:m,:) = ones(m,1)*p_i' + s*(p_f - p_i)';
    p_d(m+1:n,:) = ones(n-m,1)*p_f';
    dp_d(1:m,:) = ds*(p_f - p_i)';
    ddp_d(1:m,:) = dds*(p_f - p_i)';

% sample time for plots
  Ts = Tc;


