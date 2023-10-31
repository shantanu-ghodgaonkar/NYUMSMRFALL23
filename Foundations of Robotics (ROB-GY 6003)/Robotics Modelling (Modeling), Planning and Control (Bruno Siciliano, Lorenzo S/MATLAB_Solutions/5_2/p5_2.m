%p5_2   Plots of Problem 5.2.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% current
  subplot(2,2,1)
  plot(time, curr);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[A]');
  title('current');

% velocity
  subplot(2,2,2)
  plot(time, omega);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad/s]');
  title('velocity');
