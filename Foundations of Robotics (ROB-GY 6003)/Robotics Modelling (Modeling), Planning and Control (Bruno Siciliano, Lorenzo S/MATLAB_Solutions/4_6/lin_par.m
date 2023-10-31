function [T,Q,dQ,ddQ] = lin_par(t,q_v,D_t,dq_i,dq_f,Ts)
%LIN_PAR Interpolating linear polynomials with parabolic blends.
%        [T,Q,dQ,ddQ] = LIN_PAR(t,q_v,D_t,dq_i,dq_f,Ts) returns a trajectory
%        of interpolating linear polynomials with parabolic blends, where:
%
%        q_v is vector of via points
%        t is vector of time instants
%        D_t is vector of durations of parabolic blends
%        dq_i and dq_f are initial and final velocities
%        Ts is sample time of trajectory
%        T, Q, dQ, ddQ are respectively vectors of time, position, velocity and
%          acceleration

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

N = max(size(t));

% time steps
  S_t = t(2:N) - t(1:N-1);

% via points velocities
  dq_v = (q_v(2:N)-q_v(1:N-1))./S_t';
  dq_v = [dq_i dq_v dq_f];

% coefficients of linear segments
  a_0 = q_v(1:N-1);
  a_1 = dq_v(2:N);

% coefficients of parabolic blends
  b_2 = 0.5*(dq_v(2:N+1) - dq_v(1:N))./D_t(1:N)';
  b_1 = 0.5*(dq_v(2:N+1) + dq_v(1:N));
  b_0 = q_v(1:N) + (dq_v(2:N+1) - dq_v(1:N)).*D_t(1:N)'/8;

% trajectory computation
  T =[];
  Q = [];
  dQ = [];
  ddQ = [];

  for k=1:N-1,

  % parabolic blend
    t_p = (-0.5*D_t(k):Ts:(0.5*D_t(k) - Ts))';
    q_p = b_2(k)*t_p.^2 + b_1(k)*t_p + b_0(k);
    dq_p = 2*b_2(k)*t_p + b_1(k);
    ddq_p = 2*b_2(k)*ones(size(t_p,1),1);

  % linear segment
    t_l =  (0.5*D_t(k):Ts:S_t(k) - 0.5*D_t(k) - Ts)';
    q_l = a_1(k)*t_l + a_0(k);
    dq_l = a_1(k)*ones(size(t_l,1),1);
    ddq_l = zeros(size(t_l,1),1);

    T = [T; t(k) + t_p; t(k) + t_l];
    Q =[Q;q_p;q_l];
    dQ =[dQ;dq_p;dq_l];
    ddQ =[ddQ;ddq_p;ddq_l];

  end;

% last parabolic blend
  t_p = (-0.5*D_t(N):Ts:(0.5*D_t(N)-Ts))';
  q_p = b_2(N)*t_p.^2 + b_1(N)*t_p + b_0(N);
  dq_p = 2*b_2(N)*t_p + b_1(N);
  ddq_p = 2*b_2(N)*ones(size(t_p,1),1);

  T = [T; t(N) + t_p];
  Q =[Q;q_p];
  dQ =[dQ;dq_p];
  ddQ =[ddQ;ddq_p];
