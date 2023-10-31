function x = c_frame(u)
%C_FRAME relative pose of the object with respect to the camera referred to
%        camera frame.
%        x = C_FRAME(u) returns the relative pose referred to the camera frame
%
%       where:
%
%       u(1:4)= relative pose in the base frame
%       w(10)  =q1+q2+q4 = phi_c

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% end-effector frame
  Re = [cos(u(10)) -sin(u(10)) 0; sin(u(10)) cos(u(10)) 0; 0 0 1];

% camera frame
  Rc = Re;

% relative pose of the object referred to camera frame
  x(1:3) = Rc'*u(1:3);
  x(4) = u(4);