function x = J_Ldq(w)
%J_LDQ  feature velocity of SCARA manipulator based on line segment features
%       and estimated zc.
%       x = J_LDQ(w) returns feature velocity as:
%
%       x = J_Ldq(w(5:14))*w(1:4)
%
%       where:
%
%       w(5:14) is the feature vector of the line segment

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global zc

x = J_L(w(5:14))*w(1:4);
