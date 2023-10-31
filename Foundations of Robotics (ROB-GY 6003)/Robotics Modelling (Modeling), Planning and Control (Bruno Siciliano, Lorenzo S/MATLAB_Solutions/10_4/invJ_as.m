function dx = invJ_as(u);
%INVJ_AS Object velocity with inverse of image Jacobian based on 2 feature points 
%        for a camera mounted on a SCARA manipulator.
%        dx = INVJ_AS(u) returns the operational space velocity of the object 
%             with respect to the camera as:
%
%        dx = Gamma(x)*inv(Ls(s))*u(5:8)
%
%        where:
%
%        x = u(1:4)  is the pose vector of the object frame with respect to the camera frame 
%        s = u(9:12) is the feature vector of points P_1 and P_2

% L. Villani, G. Oriolo, B. Siciliano
% February 2009


x = u(1:4);
e = u(5:8);
s = u(9:12);

% object position with respect to the camera
  oco = x(1:3);

% z coordinates of P_1 and P_2
  z1 = oco(3);
  z2 = z1;

% interaction matrix of P_1 and P_2
  Ls = [interaction(s(1:2),z1);interaction(s(3:4),z2)];
  Ls= Ls(1:4,[1 2 3 6]);

% inverse of the interaction matrix
  invLs = inv(Ls);

% matrix Gamma
  So = [0  -oco(3)  oco(2); oco(3)  0  -oco(1); -oco(2)  oco(1)  0];
  Gamma = [-eye(3) So(:,3); zeros(1,3)  -1];

% operational space velocity of the object with respect to the camera
  dx = Gamma*invLs*e;
