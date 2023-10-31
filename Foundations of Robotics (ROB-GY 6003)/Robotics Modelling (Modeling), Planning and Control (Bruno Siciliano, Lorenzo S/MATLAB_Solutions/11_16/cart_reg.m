function inputs = cart_reg(q)

% generates driving and steering velocity
% for cartesian regulation of a unicycle
% includes a modification to avoid useless reversals

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

global k_1 k_2

x=q(1);
y=q(2);
theta=q(3);

e_p=[-x -y];                    % pointing error vector
sag=[cos(theta);sin(theta)];    % sagittal vector
gamma=atan2(y,x)-theta+pi;      % pointing angle

% driving velocity 
v=k_1*e_p*sag;

% steering velocity
if  e_p*sag > 0
    omega=k_2*gamma;
else
    omega=k_2*(gamma-pi*sign(gamma));
end

inputs=[v;omega];