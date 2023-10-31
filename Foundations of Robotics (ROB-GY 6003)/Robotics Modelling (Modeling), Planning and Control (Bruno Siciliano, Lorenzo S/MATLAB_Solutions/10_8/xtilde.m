function e = xtilde(u)
%XTILDE position error in the operational space of SCARA manipulator.
%       e = XTILDE(u) returns the position error vector
%
%       where:
%
%       u(1:4)=[o_do;phi_do]
%       u(5:8)=[o_co;phi_co]

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

o_do = u(1:3);
phi_do = u(4);

o_co = u(5:7);
phi_co = u(8);

T_do = eye(4);
T_co = eye(4);

R_do = [cos(phi_do) -sin(phi_do) 0; sin(phi_do) cos(phi_do) 0; 0 0 1]; 

R_co = [cos(phi_co) -sin(phi_co) 0; sin(phi_co) cos(phi_co) 0; 0 0 1];

T_do(1:3,1:3) = R_do;
T_do(1:3,4) = o_do;

T_co(1:3,1:3) = R_co;
T_co(1:3,4) = o_co;

T_dc = T_do*inv(T_co);

e = zeros(4,1);
e(1:3,1) = -T_dc(1:3,4);
e(4) = -phi_do + phi_co;