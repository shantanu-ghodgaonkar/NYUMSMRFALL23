function s  = features_p(x);
%FEATURES_P  Feature vector of points P1 and P2.
%            s = FEATURES_P(x) returns the feature vector of points P1 and P2
%
%            where:
%
%            x = relative pose of object frame with respect to camera frame.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009


% homogeneous transformation matrix of object frame with respect to camera frame 
  oco = x(1:3);
  phi = x(4);
  Rz = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0; 0 0 1];
  Roc = Rz;
  Toc = [Roc oco; 0 0 0 1];

% position vectors of P1 and P2 in the objet frame  
  tro1 = [0;0;0;1]; 
  tro2 = [0.1;0;0;1];

% position vectors of P1 and P2 in the camera frame
  trc1  = Toc*tro1;
  trc2  = Toc*tro2;

% feature vector
  s1 = [trc1(1) ;trc1(2)]*(1/trc1(3));
  s2 = [trc2(1) ;trc2(2)]*(1/trc2(3));
  
  s = [s1;s2];