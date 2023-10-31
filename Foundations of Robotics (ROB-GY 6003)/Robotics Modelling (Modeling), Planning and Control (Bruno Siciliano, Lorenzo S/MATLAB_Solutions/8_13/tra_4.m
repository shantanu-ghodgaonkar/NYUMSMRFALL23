%TRA_4  Generation of trajectory #4.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% initial joint configuration
  q_i = [0;pi/4];

% final joint configuration
  q_f = [pi/2;pi/2];

% time base vector
  T = (0:Tc:t_d)';

% final time
  t_f = 1;

% trapezoidal velocity profile trajectory for joint 1
  dq_c = 3*pi/4;             % maximum velocity
  [T_1,q_1,dq_1,ddq_1,err] = trapez(q_i(1),q_f(1),dq_c,t_f,Tc);

% trapezoidal velocity profile trajectory for joint 2
  dq_c = pi/3;               % maximum velocity
  [T_1,q_2,dq_2,ddq_2,err] = trapez(q_i(2),q_f(2),dq_c,t_f,Tc);

% joint space trajectory of t_d sec duration
  n = size(T,1);
  m = size(T_1,1);
  q_d = zeros(n,2);
  dq_d = q_d;
  ddq_d = q_d;

  q_d(1:m,:) = [q_1 q_2];
  q_d(m+1:n,:) = ones(n-m,1)*q_f';
  dq_d(1:m,:)  = [dq_1 dq_2];
  ddq_d(1:m,:) = [ddq_1 ddq_2];

clear T_1 q_1 dq_1 ddq_1 T_2 q_2 dq_2 ddq_2
