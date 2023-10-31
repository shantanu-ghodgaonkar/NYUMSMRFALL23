%P7_7   Plots of Problem 7.7.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% joint torques
  subplot(2,2,1);
  plot(time, tau_1);
  axis([0 t_d -1e4 1.5e4]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[Nm]');
  title('joint 1 torque');

  subplot(2,2,2);
  plot(time, tau_2);
  axis([0 t_d -1e4 1.5e4]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[Nm]');
  title('joint 2 torque');
