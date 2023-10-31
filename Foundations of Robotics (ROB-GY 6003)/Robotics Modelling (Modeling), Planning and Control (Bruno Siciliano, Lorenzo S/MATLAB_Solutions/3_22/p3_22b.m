%P3_22B Plots of Problem 3.22 (case B).

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% joint positions
  subplot(2,2,1);
  plot(time, q);
  pt(1) = text(2.0, 1.9,'1');
  pt(2) = text(2.0, -1.7,'2');
  pt(3) = text(2.0, 0.0,'3');
  pt(4) = text(2.0, 1.05 ,'4');

%  for i=1:4,
%      set(pt(i),'fontname','Times','fontsize',12,'fontweight','normal');
%  end

  axis([0 t_d -3 3]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('joint pos');

% joint velocities
  subplot(2,2,2);
  plot(time, dq);
  pt(1) = text(0.25, 1.15,'1');
  pt(2) = text(0.25, -0.85,'2');
  pt(3) = text(0.75, 0.65,'3');
  pt(4) = text(1.15, -0.75,'4');

%  for i=1:4,
%      set(pt(i),'fontname','Times','fontsize',12,'fontweight','normal');
%  end

  axis([0 t_d -2 2]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad/s]');
  title('joint vel');

% position error norm
  subplot(2,2,3);
  plot(time, sqrt(e(:,1).^2 + e(:,2).^2) + e(:,3).^2);
  axis([0 t_d 0 0.01]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[m]');
  title('pos error norm');

% orientation error
  subplot(2,2,4);
  plot(time, e(:,4));
  axis([0 t_d -6e-3 6e-3]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('orien error');
