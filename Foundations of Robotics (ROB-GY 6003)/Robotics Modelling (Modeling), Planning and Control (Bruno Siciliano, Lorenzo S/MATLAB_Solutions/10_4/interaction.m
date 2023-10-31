function L = interaction(s,z);
%INTERACTION Interaction matrix of a point.
%            L = INTERACTION(s,z) returns the interaction matrix of a point with:
%            
%            s = feature vector of the point
%            z = third component of the position vector of the point in the camera frame.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

X=s(1);
Y=s(2);

L = [-1/z  0  X/z  X*Y  -(1+X*X)  Y; 0  -1/z  Y/z  1+Y*Y  -X*Y  -X];