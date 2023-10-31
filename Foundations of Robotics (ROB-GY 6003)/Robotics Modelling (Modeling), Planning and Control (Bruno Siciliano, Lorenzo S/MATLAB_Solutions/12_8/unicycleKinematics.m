function dq = unicycleKinematics( t, q, v ,omega )

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

dq = [ v*cos(q(3)); v*sin(q(3)); omega ];