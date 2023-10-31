function Jaq= J_aq(u)
%J_AQ   Jacobian of SCARA manipulator in the operational space.
%       Jaq = J_AQ(u) returns 4-by-4 analytical Jacobian referred to 
%       the desired camera frame, where:
%
%       u(1:4)=[a(1)*c_1;a(2)*c_12;a(1)*s_1;a(2)*s_12]
%       u(6)  =q1+q2+q4 = phi_c
%       u(10) =phi_d - phi_c 

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% analytical Jacobian referred to the base frame
  Jaq = zeros(4,4);
  Jaq(1:2,2) = [-u(4); u(2)];
  Jaq(4,2) = 1;
  Jaq(1:2,1) = [-u(3); u(1)] + Jaq(1:2,2);
  Jaq(4,1) = 1;
  Jaq(3,3) = 1;
  Jaq(4,4) = 1;

% desired camera frame
  phi_d = u(6) + u(10);
  Rd = [cos(phi_d) -sin(phi_d) 0; sin(phi_d) cos(phi_d) 0; 0 0 1];

% analytical Jacobian referred to the desired camera frame
Jaq = [Rd' zeros(3,1); zeros(1,3) 1]*Jaq;