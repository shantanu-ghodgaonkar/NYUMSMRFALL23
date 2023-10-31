%P9_10   Plots of Problem 9.10.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% velocity error
  subplot(2,2,1)
  plot(time, e_nu);
  axis([0 t_d -2e-3 2e-3]);
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[m/s]');
  title('vel error');

% contact force
  subplot(2,2,2)
  plot(time, lam);
  axis([0 t_d -60 0]);
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[N]');
  title('force');

% tip's path force
  figure
  subplot(2,2,1)
  plot(o_e(:,1),o_e(:,2));
  hold on
  plot([0.98 1.25], [-0.02 0.25],'--');
  axis('square')
  axis([0.98 1.25 -0.02 0.25]);
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[m]');
  ylabel('[m]');
