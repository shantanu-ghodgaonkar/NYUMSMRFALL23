% s11_13   Solution to Problem 11.13
% path planning for the unicycle via Cartesian cubic polynomials

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all;close all;

%%%%%%%%%%%%%%%%
% user: choose %
%%%%%%%%%%%%%%%%

x_i=0; y_i=0; theta_i=0;     % initial configuration
x_f=2; y_f=1; theta_f=pi/2;  % final configuration

N=100; % number of sampling intervals in s=[0,1]

k=1;   % k=ki=kf same value for initial and final geometric velocity 

%%%%%%%%%%%%%%%
% computation %
%%%%%%%%%%%%%%%

% parameters of the cubic polynomial

alfa=[k*cos(theta_f)-3*x_f; k*sin(theta_f)-3*y_f];
alfa_x=alfa(1);
alfa_y=alfa(2);

beta=[k*cos(theta_i)+3*x_i;k*sin(theta_i)+3*y_i];
beta_x=beta(1);
beta_y=beta(2);

% vector for trajectory parametrization

s=(1/N)*[0:1:N]; 

% x(s),y(s) and their first and second derivative wrt s

x=-(s-1).^3*x_i+s.^3*x_f+alfa_x*(s.^2).*(s-1)+beta_x*s.*((s-1).^2);
y=-(s-1).^3*y_i+s.^3*y_f+alfa_y*(s.^2).*(s-1)+beta_y*s.*((s-1).^2);
 
xp= -3*(s-1).^2 *x_i+3*s.^2 *x_f+alfa_x*(3*s.^2-2*s)+beta_x*(3*s.^2-4*s +1); 
yp= -3*(s-1).^2 *y_i+3*s.^2 *y_f+alfa_y*(3*s.^2-2*s)+beta_y*(3*s.^2-4*s +1); 

xpp= -6*(s-1)*x_i+6*s*x_f+alfa_x*(6*s-2)+beta_x*(6*s-4); 
ypp= -6*(s-1)*y_i+6*s*y_f+alfa_y*(6*s-2)+beta_y*(6*s-4); 
 
% theta(s) and geometric inputs computed via flatness

theta=atan2(yp,xp);

tildev=xp.*cos(theta)+yp.*sin(theta);
tildeomega=(ypp.*xp-xpp.*yp)./(xp.^2+yp.^2);

% plot

p11_13






