%s7_7   Solution to Problem 7.7.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

clear all

% first trajectory
  % trajectory generation
    tra_1;

  % tip forces
    f = [500;500];

  % inverse dynamics
    inv_d;

  % plot
    figure(1)
    p7_7;

  clear

% second trajectory
  % trajectory generation
    tra_2;

  % tip forces
    f = [500;500];

  % inverse dynamics
    inv_d;

  % plot
    figure(2);
    p7_7;

  clear

% third trajectory
  % trajectory generation
    tra_3;

  % tip forces
    f = [500;500];

  % inverse dynamics
    inv_d;

  % plot
    figure(3);
    p7_7;
