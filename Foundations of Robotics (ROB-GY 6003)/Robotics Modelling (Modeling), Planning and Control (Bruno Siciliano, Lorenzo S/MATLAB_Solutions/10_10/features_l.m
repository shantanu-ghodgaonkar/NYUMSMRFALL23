function s  = features_l(x);
%FEATURES_L  Feature vector of line segment connecting two points.
%            s = FEATURES_L(x) returns the feature vector of line segment
%
%            where:
%
%            x = [X_1;Y_1;X_2;Y_2] image-plane coordinates of the two end-points.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

X_1 = x(1);
Y_1 = x(2);
X_2 = x(3);
Y_2 = x(4);

xm = (X_1+X_2)/2;
ym = (Y_1+Y_2)/2;
DX = X_2-X_1;
DY = Y_2-Y_1;
L = sqrt(DX^2+DY^2);
alpha = atan(DY/DX);

s = [xm;ym;L;alpha];