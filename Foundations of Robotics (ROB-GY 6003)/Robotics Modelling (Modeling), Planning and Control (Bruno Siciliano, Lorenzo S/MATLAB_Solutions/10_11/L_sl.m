function Ls = L_sl(u);
%L_SL Interaction matrix of a line segment (with estimated zc)
%     LS = L_SL(u) returns the interaction matrix of a line segment
%
%     where:
%
%     u is the feature vector of the line segment

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global zc
xm = u(1);
ym = u(2);
L = u(3);
alpha = u(4);

% segment endpoins P_1 and P_2
  X_1 = xm - 0.5*L*cos(alpha);
  Y_1 = ym - 0.5*L*sin(alpha);

  X_2 = xm + 0.5*L*cos(alpha);
  Y_2 = ym + 0.5*L*sin(alpha);

% interaction matrices of P_1 and P_2
  Ls1 = [interaction([X_1;Y_1],zc(1))];
  Ls2 = [interaction([X_2;Y_2],zc(2))];

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
