%TRA_1  Generation of trajectory #1.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% link lengths
  a  = [1;1];

% initial tip position
  x_i = [0.2;0];

% initial joint configuration
  q_i = inv_k2d(a,x_i);

% sample time
  Ts = 1e-3;

% duration
  t_d = 0.6;

% time base vector
  time = 0:Ts:t_d;

% trajectory parameters
  dq_M =  2*pi;      % maximum velocity
  Delta_q =  0.5*pi; % joint total variation
  t_f  =  0.5;       % final time

% triangular velocity profile trajectory from 0 to Delta_q
  [T,q_t,dq_t,ddq_t,err]=trapez(0,Delta_q,dq_M,t_f,Ts);

% joint space trajectory of t_d sec duration
  n = size(time,2);
  m = size(T,1);
  q = zeros(2,n);
  dq = q;
  ddq = q;

  % position
    q_ta = [q_t; Delta_q*ones(n-m,1)];
    q(1,:) = q_i(1)*ones(1,n) + q_ta';
    q(2,:) = q_i(2)*ones(1,n) + q_ta';

  % velocity
    dq(1,1:m) = dq_t';
    dq(2,1:m) = dq(1,1:m);

  % acceleration
    ddq(1,1:m) = ddq_t';
    ddq(2,1:m) = ddq(1,1:m);

clear T q_t dq_t ddq_t q_ta
