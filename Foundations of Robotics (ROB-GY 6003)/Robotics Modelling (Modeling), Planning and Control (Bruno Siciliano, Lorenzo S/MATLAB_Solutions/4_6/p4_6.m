%P4_6   Plots of Problem 4.6.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% position
%  subplot(4,2,1)
  subplot(2,2,1)
  plot(t(1),q_v(1),'o',t(2),q_v(2),'o',t(3),q_v(3),'o',time,q)
  axis([t(1)-0.5*D_t(1) t(3)+0.5*D_t(1) -0.5 3.5]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  title('pos');
  xlabel('[s]');
  ylabel('[rad]');

% velocity
%  subplot(4,2,2)
  subplot(2,2,2)
  plot(time,dq);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([t(1)-0.5*D_t(1) t(3)+0.5*D_t(1) -0.5 2]);
  title('vel');
  xlabel('[s]')
  ylabel('[rad/s]')

% acceleration
%  subplot(4,2,3)
  subplot(2,2,3)
  plot(time,ddq);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([t(1)-0.5*D_t(1) t(3)+0.5*D_t(1) -6 6]);
  title('acc');
  xlabel('[s]')
  ylabel('[rad/s^2]')

%set(1,'papertype','a4');
%set(1,'paperPosition',[0.25 0 16 12]);
%h = get(1,'Child');
%p = [0.065 0.2925 0.16 0.17];
%set(h(1),'pos',p);
%p(2) = 0.53;
%set(h(2),'pos',p);
%p(2) = 0.7675;
%set(h(3),'pos',p);
