function dx = invJ_asl(u);
%INVJ_ASL Object velocity with inverse of image Jacobian based on line segment features 
%         for a camera mounted on a SCARA manipulator.
%         dx = INVJ_AS(u) returns the operational space velocity of the object 
%              with respect to the camera as:
%
%         dx = Gamma(x)*inv(Ls(s))*u(5:8)
%
%         where:
%
%         x = u(1:4)  is the pose vector of the object frame with respect to the camera frame 
%         s = u(9:12) is the feature vector of the line segment

% L. Villani, G. Oriolo, B. Siciliano
% February 2009


x = u(1:4);
e = u(5:8);
xm = u(9);
ym = u(10);
L = u(11);
alpha = u(12);

% object position with respect to the camera
  oco = x(1:3);

% z coordinates of the endpoints P_1 and P_2
  z1 = oco(3);
  z2 = z1;

% image plane coordinates of endpoins P_1 and P_2
  X_1 = xm - 0.5*L*cos(alpha);
  Y_1 = ym - 0.5*L*sin(alpha);

  X_2 = xm + 0.5*L*cos(alpha);
  Y_2 = ym + 0.5*L*sin(alpha);

% interaction matrices of P_1 and P_2
  Ls1 = [interaction([X_1;Y_1],z1)];
  Ls2 = [interaction([X_2;Y_2],z2)];

% Jacobians of line segment features
  DX = X_2-X_1;
  DY = Y_2-Y_1;
  ds1 = [ 1/2      0
         0         1/2
        -DX/L     -DY/L
         DY/(L^2) -DX/(L^2)];

   ds2 = [ 1/2      0
           0        1/2
          DX/L      DY/L
         -DY/(L^2)  DX/(L^2)];

% interaction matrix of line segment
  Ls = ds1*Ls1 + ds2*Ls2;
  Ls = Ls(1:4,[1 2 3 6]);

% inverse of the interaction matrix
  invLs = inv(Ls);

% matrix Gamma
  So = [0  -oco(3)  oco(2); oco(3)  0  -oco(1); -oco(2)  oco(1)  0];
  Gamma = [-eye(3) So(:,3); zeros(1,3)  -1];

% operational space velocity of the object with respect to the camera
  dx = Gamma*invLs*e;
