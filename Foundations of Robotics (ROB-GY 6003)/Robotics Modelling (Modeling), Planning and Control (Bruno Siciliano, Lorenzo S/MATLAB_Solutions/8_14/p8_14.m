%P8_14  Plots of Problem 8.14.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% joint position errors
  subplot(2,2,1)
  plot(time, e(:,1),time,e(:,2),'--');
  axis([0 t_d -1e-3 1e-3]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('joint pos errors');

% load mass estimate
  subplot(2,2,2)
  plot(time, m_l);
  axis([0 t_d 0 20]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[kg]');
  title('load mass estimate');
