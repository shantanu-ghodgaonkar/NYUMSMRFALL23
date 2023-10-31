function inputs=post_reg(q)

% generates driving and steering velocity
% for posture regulation of a unicycle

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global k_1 k_2 k_3

rho=q(1);
gamma=q(2);
delta=q(3);

% driving velocity 
v=k_1*rho*cos(gamma);

if gamma==0
    sinc=1;
else sinc=sin(gamma)/gamma;
end

% steering velocity
omega=k_2*gamma+k_1*sinc*cos(gamma)*(gamma+k_3*delta);

inputs=[v;omega];
