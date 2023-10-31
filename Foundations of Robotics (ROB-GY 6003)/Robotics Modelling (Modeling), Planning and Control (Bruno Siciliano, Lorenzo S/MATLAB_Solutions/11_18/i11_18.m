% i11_18   Initialization for Solution to Problem 11.18

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all;

global k_1 k_2 k_3

% simulation time
T=10;

% initial configuration of the unicycle
x_0=-1;
y_0=-2;
theta_0=-pi/2;

% sampling interval for odometric localization
%T_s=0.1;
T_s=0.01;

% posture regulator gains
k_1=1;
k_2=2.5;
k_3=3;