% i11_16   Initialization for Solution to Problem 11.16

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all;

global k_1 k_2

% simulation time
T=10;

% initial configuration of the unicycle
x_0=-1;
y_0=-2;
theta_0=-pi/2;

% cartesian regulator gains
k_1=1;
k_2=3;