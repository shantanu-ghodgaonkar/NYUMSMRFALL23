%TRA_5  Generation of trajectory #5.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% time base vector
  T = (0:Tc:t_d)';

% segment length
  D_s = norm(p_f - p_i);

% trapezoidal velocity profile trajectory for path coordinate from 0 to 1
  ds_c = 0.5;                % maximum velocity
  t_f  = 1;                  % final time
  [T_1,s,ds,dds,err] = trapez(0,1,ds_c/D_s,t_f,Tc);

  n = size(T,1);
  m = size(T_1,1);
  o_d = zeros(n,2);
  do_d = o_d;
  ddo_d = o_d;

% tip trajectory
  o_d(1:m,:) = ones(m,1)*p_i' + s*(p_f - p_i)';
  o_d(m+1:n,:) = ones(n-m,1)*p_f';
  do_d(1:m,:) = ds*(p_f - p_i)';
  ddo_d(1:m,:) = dds*(p_f - p_i)';
