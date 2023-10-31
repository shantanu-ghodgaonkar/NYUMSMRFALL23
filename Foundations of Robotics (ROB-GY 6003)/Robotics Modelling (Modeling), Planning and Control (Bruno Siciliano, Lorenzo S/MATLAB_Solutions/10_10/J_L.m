function JL = J_L(u)
%%J_L   image Jacobian of SCARA manipulator based on line segment features
%       and estimated zc.
%       JL = J_L(u) returns 4-by-4 image Jacobian 
%
%       where:
%
%       u(1:4) =[a(1)*c_1;a(2)*c_12;a(1)*s_1;a(2)*s_12]
%       u(6)   =q1+q2+q4 = phi_c
%       u(7:10)=s 

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global zc

s = u(7:10);

% analytical Jacobian referred to the base frame
  Jaq = zeros(4,4);
  Jaq(1:2,2) = [-u(4); u(2)];
  Jaq(4,2) = 1;
  Jaq(1:2,1) = [-u(3); u(1)] + Jaq(1:2,2);
  Jaq(4,1) = 1;
  Jaq(3,3) = 1;
  Jaq(4,4) = 1;

% camera frame
  Rc = [cos(u(6)) -sin(u(6)) 0; sin(u(6)) cos(u(6)) 0; 0 0 1];
      
% analytical Jacobian referred to the camera frame
  Jaq = [Rc' zeros(3,1); zeros(1,3) 1]*Jaq;


% image Jacobian of SCARA manipulator
  JL = L_sl(s)*Jaq; 