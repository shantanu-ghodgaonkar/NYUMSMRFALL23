%P4_5   Plots of Problem 4.5.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% position
%  subplot(4,2,1)
  subplot(2,2,1)
  plot(t(1),q_i(1),'o',t(2),0,'x',t(3),q_m,'o',t(4),0,'x',...
       t(5),q_f(1),'o',time,q);
  axis([0 t(5) -0.5 3.5]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  title('pos');
  xlabel('[s]');
  ylabel('[rad]');

% velocity
%  subplot(4,2,2)
  subplot(2,2,2)
  plot(time,dq);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([0 t(5) -0.5 2]);
  title('vel');
  xlabel('[s]')
  ylabel('[rad/s]')

% acceleration
%  subplot(4,2,3)
  subplot(2,2,3)
  plot(time,ddq);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([0 t(5) -3 3]);
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
