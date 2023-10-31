%I9_10   Variables initialization for Problem 9.10.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global a k_r1 k_r2 pi_m pi_l

% load manipulator dynamic parameters without load mass
  param;
  pi_l = pi_m;

% gravity acceleration
  g = 9.81;

% friction matrix
  K_r = diag([k_r1 k_r2]);
  F_v = K_r*diag([0.01 0.01])*K_r;

% sample time of controller
  Tc = 0.001;

% constraint frame matrix
  R_c = [cos(pi/4)  -sin(pi/4);
        sin(pi/4)  cos(pi/4)];

% positive semi-definite stiffness matrix in the base frame
  K = R_c*[0 0;0 5e3]*R_c';

% position of undeformed plane
  o_r = [1;0];

% positive definite estimated compliance matrix in the constraint frame
  Ch = [1/4e3 0;0 1/4e3];

% positive definite estimated stiffness matrix in the constraint frame
  Kh = [4e3 0;0 4e3];

% positive semi-definite estimated compliance matrix in the constraint frame
  Cp = [0 0;0 1/4e3];

% selection matrices in the constraint frame
  S_f = [0;1];
  S_v = [1;0];

  pS_f = inv(S_f'*Ch*S_f)*S_f'*Ch;
  pS_v = inv(S_v'*Kh*S_v)*S_v'*Kh;

% matrix gain for force derivative estimation
  G_f =inv (S_f'*Ch*S_f)*S_f'; 

% force control gains
  K_Dl = 16;
  K_Pl = 100;

% motion control gains
  K_Pnu = 16;
  K_Inu = 100;

% initial position
  p_0 = [1; 0];

% initial joint configuration
  q_i = inv_k2u(a,p_0);

% motion trajectory of Problem 9.3
  p_i = [1+0.2*cos(pi/4); 0];
  p_f = [1.2+0.2*cos(pi/4);0.2];
  t_d = 2.5;
  tra_5;

% desired velocity in the constraint frame 
  v_d = do_d*R_c;

% desired acceleration in the constraint frame 
  a_d = ddo_d*R_c;

% desired force in the constraint frame 
  h_d = [0;- 50];

% sample time for plots
  Ts = Tc;