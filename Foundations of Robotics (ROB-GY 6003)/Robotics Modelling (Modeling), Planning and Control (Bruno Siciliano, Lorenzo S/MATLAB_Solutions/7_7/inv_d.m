%INV_D  Inverse dynamics for a two-link planar arm.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% load manipulator dynamic parameters
  param

% gravity acceleration
  g = 9.81;

% sinusoidal functions
  c_1 = cos(q(1,:));
  s_1 = sin(q(1,:));
  c_2 = cos(q(2,:));
  s_2 = sin(q(2,:));
  q_12 = q(1,:) + q(2,:);
  c_12 = cos(q_12);
  s_12 = sin(q_12);

% inertial contributions
  b_11 = a(1)*pi_m(1) + pi_m(2) + (a(2) + 2*a(1)*c_2)*pi_m(3) + pi_m(4);
  b_12 = (a(2) + a(1)*c_2)*pi_m(3) + pi_m(4) + k_r2*pi_m(5);
  b_22 = a(2)*pi_m(3) + pi_m(4) + k_r2*k_r2*pi_m(5);

  inert_11 = b_11.*ddq(1,:);
  inert_12 = b_12.*ddq(2,:);
  inert_21 = b_12.*ddq(1,:);
  inert_22 = b_22.*ddq(2,:);

% Coriolis and centrifugal contributions
  h = -a(1)*pi_m(3)*s_2;
  cen_2 =  h.*dq(2,:).^2;
  cor_12 = 2.*h.*dq(1,:).*dq(2,:);
  cen_1 = -h.*dq(1,:).^2;

% gravitational contributions
  grav_2 = g*c_12*pi_m(3);
  grav_1 = grav_2 + g*c_1*pi_m(1);

% tip force contributions
  tau_f1 = -a(1)*s_1*f(1)-a(2)*s_12*(f(1)+f(2));
  tau_f2 =  a(1)*c_1*f(1)+a(2)*s_12*(f(1)+f(2));

% input torques
  tau_1 = inert_11 + inert_12 + cen_2 + cor_12 + grav_1 + tau_f1;
  tau_2 = inert_21 + inert_22 + cen_1 + grav_2 + tau_f2;
