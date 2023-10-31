function [T,Q,dQ,ddQ] = spline_c(q_i,q_f,q_m,t,Ts)
%SPLINE_C Cubic spline.
%         [T,Q,dQ,ddQ] = SPLINE_C(q_i,q_f,q_m,t,Ts) returns cubic spline
%         from initial position q_i(1) to final position q_f(1) with
%         initial velocity and acceleration q_i(2) and q_i(3), and
%         final velocity and acceleration q_f(2) and q_f(3), where:
%
%         q_m is vector of intermediate positions
%         t is vector of time instants (including initial, final and
%           virtual instants)
%         Ts is sample time of trajectory
%         T, Q, dQ, ddQ are respectively vectors of time, position,
%           velocity and acceleration

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

N = max(size(t)) - 2;

q = [q_i(1) 0 q_m 0 q_f(1)];
A = zeros(N,N);
b = zeros(N,1);

% builds vector D_t
  D_t = t(2:N+2) - t(1:N+1);

% builds vector D_f = 1/D_t
  D_f = 1./D_t;

% builds matrix A
  A(1,1) = D_t(1)/2 + D_t(2)/3 + D_f(2)*(D_t(1)^2)/6;
  for k = 2:N-1,
      A(k,k) = (D_t(k) + D_t(k+1))/3;
  end;
  A(N,N) = D_t(N)/3 + D_t(N+1)/2 + D_f(N)*(D_t(N+1)^2)/6;
  A(2,1) = (D_t(2) - D_f(2)*D_t(1)^2)/6;
  for k = 3:N,
      A(k,k-1) = D_t(k)/6;
      A(k-2,k-1) = D_t(k-1)/6;
  end;
  A(N-1,N) = (D_t(N)-D_f(N)*D_t(N+1)^2)/6;

% builds vector b
  b(1) = (q(3) - q_i(1))*D_f(2) - (D_f(2) + D_f(1))*(q_i(2) + ...
          q_i(3)*D_t(1)/3)*D_t(1) - D_t(1)*q_i(3)/6;
  if N>3,
     b(2) = D_f(2)*(q_i(1) + (q_i(2) + q_i(3)*D_t(1)/3)*D_t(1)) - ...
            (D_f(3) + D_f(2))*q(3) + q(4)*D_f(3);
     b(N-1) = q(N-1)*D_f(N-1) - (D_f(N) + D_f(N-1))*q(N) + ...
              D_f(N)*(q_f(1) + (-q_f(2) + q_f(3)*D_t(N+1)/3)*D_t(N+1));
     for k = 3:N-2
         b(k) = q(k)*D_f(k) - (D_f(k+1) + D_f(k))*q(k+1) + ...
               q(k+2)*D_f(k+1);
    end;
  else
     b(2) = D_f(2)*(q_i(1) + (q_i(2)+ q_i(3)*D_t(1)/3)*D_t(1)) - ...
            (D_f(3) + D_f(2))*q(3) + D_f(3)*(q_f(1) + (-q_f(2) + ...
            q_f(3)*D_t(4)/3)*D_t(4));
  end;
  b(N) = (q(N) - q_f(1))*D_f(N) - (D_f(N+1) + D_f(N))*(-q_f(2) + ...
         q_f(3)*D_t(N+1)/3)*D_t(N+1) - D_t(N+1)*q_f(3)/6;

% solves linear system A*a=b
  a = A\b;

% builds trajectory
  a = [q_i(3);a;q_f(3)];
  q(2) = q_i(1) + (q_i(2) + (q_i(3)/3 + a(2)/6)*D_t(1))*D_t(1);
  q(N+1) = q_f(1) + (-q_f(2) + (q_f(3)/3 + a(N+1)/6)*D_t(N+1))*D_t(N+1);
  T =[];
  Q = [];
  dQ = [];
  ddQ = [];
  for k=1:N+1,
      t_k = (0:Ts:D_t(k)-Ts)';
      t_h = D_t(k)-t_k;
      q_k = (a(k)*t_h.^3 + a(k+1)*t_k.^3)*D_f(k)/6 + ...
            (q(k+1)*D_f(k)-D_t(k)*a(k+1)/6)*t_k + (q(k)*D_f(k) - ...
            D_t(k)*a(k)/6)*t_h;
      dq_k = (-0.5*a(k)*t_h.^2 + 0.5*a(k+1)*t_k.^2 + q(k+1) - ...
             q(k))*D_f(k) + (a(k) - a(k+1))*D_t(k)/6;
      ddq_k = (a(k)*t_h + a(k+1)*t_k)*D_f(k);
      T = [T;t(k)+t_k];
      Q =[Q;q_k];
      dQ =[dQ;dq_k];
      ddQ =[ddQ;ddq_k];
  end;
