function ang_out=wrap(ang_in)
% wraps an angle so that it is contained
% in [-pi,pi)

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

ang_out=mod(ang_in+pi,2*pi)-pi;