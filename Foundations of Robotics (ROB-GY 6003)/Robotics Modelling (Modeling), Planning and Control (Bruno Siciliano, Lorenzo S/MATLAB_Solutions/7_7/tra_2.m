%TRA_2  Generation of trajectory #2.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% link lengths
  a  = [1;1];

% initial tip position
  x_i = [0.2;0];

% initial joint configuration
  q_i = inv_k2d(a,x_i);

% final tip position
  x_f = [1.8;0];

% final joint configuration
  q_f= inv_k2d(a,x_f);

% sample time
  Ts = 1e-3;

% duration
  t_d = 0.66;

% time base vector
  time = 0:Ts:t_d;

% trajectory generation
  n = size(time,2);
  q = zeros(2,n);
  dq = q;
  ddq = q;

% trajectory parameters for joint 1
  dq_M = 5;                             % maximum velocity
  t_a  = 0.15;                          % acceleration time
  t_f  = abs(q_f(1)-q_i(1))/dq_M + t_a; % final time

% trapezoidal velocity profile trajectory for joint 1
  [T,q_t,dq_t,ddq_t,err]=trapez(q_i(1),q_f(1),dq_M,t_f,Ts);

% joint space trajectory of t_d sec duration for joint 1
  m = size(T,1);
  q(1,:) = [q_t' q_f(1)*ones(1,n-m)];
  dq(1,1:m) = dq_t';
  ddq(1,1:m) = ddq_t';

  clear T dq_t dq_t ddq_t

% trajectory parameters for joint 2
  dq_M = 5;                             % maximum velocity
  t_a  = 0.15;                          % acceleration time
  t_f  = abs(q_f(2)-q_i(2))/dq_M + t_a; % final time

% trapezoidal velocity profile trajectory for joint 2
  [T,q_t,dq_t,ddq_t,err]=trapez(q_i(2),q_f(2),dq_M,t_f,Ts);

% joint space trajectory of t_d sec duration for joint 2
  m = size(T,1);
  q(2,:) = [q_t' q_f(2)*ones(1,n-m)];
  dq(2,1:m) = dq_t';
  ddq(2,1:m) = ddq_t';

clear T dq_t dq_t ddq_t
