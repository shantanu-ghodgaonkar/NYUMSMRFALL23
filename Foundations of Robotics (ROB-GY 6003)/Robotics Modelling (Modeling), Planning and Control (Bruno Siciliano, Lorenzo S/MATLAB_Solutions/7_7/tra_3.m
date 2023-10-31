%TRA_3  Generation of trajectory #3.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% link lengths
  a = [1;1];

% initial tip position
  x_i = [0.2;0];

% final tip position
  x_f = [1.8;0];

% sample time
  Ts = 1e-3;

% duration
  t_d = 0.6;

% time base vector
  time = 0:Ts:t_d;

% trajectory parameters in operational space
  dx_M = 5;                             % maximum velocity
  t_a  = 0.15;                          % acceleration time
  t_f  = abs(x_f(1)-x_i(1))/dx_M + t_a; % final time

% trapezoidal velocity profile trajectory for x coordinate
  [T,x_t,dx_t,ddx_t,err] = trapez(x_i(1),x_f(1),dx_M,t_f,Ts);

% operational space trajectory for x and y coordinates of t_d duration
  n = size(time,2);
  m = size(T,1);
  x = zeros(2,n);
  dx = x;
  ddx = x;

  x(1,:) = [x_t' x_f(1)*ones(1,n-m)];
  dx(1,1:m) = dx_t';
  ddx(1,1:m) = ddx_t';

% inverse kinematics for joint space trajectory generation
  q = zeros(2,n);
  dq = q;
  ddq = q;

  for i=1:m,
      qi = inv_k2d(a,x(:,i));
      w = [dx(:,i);
           a(1)*cos(qi(1));a(2)*cos(qi(1)+qi(2));
           a(1)*sin(qi(1));a(2)*sin(qi(1)+qi(2))];
      dqi = invJ_a(w);
      w(1:2) = dqi;
      w(1:2) = ddx(:,i) - dJ_a(w);
      ddq(:,i) = invJ_a(w);
      dq(:,i) = dqi;
      q(:,i) = qi;
  end;

  q(:,(m+1):n) = q(:,m)*ones(1,n-m);

clear T x_t dx_t ddx_t
