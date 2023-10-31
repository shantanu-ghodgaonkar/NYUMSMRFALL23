%P4_3   Plots of Problem 4.3.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% position
%  subplot(4,2,1)
  subplot(2,2,1)
  plot(t(1),q_i(1),'o',time_1,q_1,...
       t(2),q_m(1),'o',time_2,q_2,t(3),q_f(1),'o');
  axis([0 t(3) -0.5 3.5]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  title('pos');
  xlabel('[s]');
  ylabel('[rad]');

% velocity
%  subplot(4,2,2)
  subplot(2,2,2)
  plot(t(1),q_i(2),'o',time_1,dq_1,...
       t(2),q_m(2),'o',time_2,dq_2,t(3),q_f(2),'o');
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([0 t(3) -0.5 2]);
  title('vel');
  xlabel('[s]')
  ylabel('[rad/s]')

% acceleration
%  subplot(4,2,3)
  subplot(2,2,3)
  plot(t(1),q_i(3),'o',time_1,ddq_1,...
       t(2),q_m(3),'o',time_2,ddq_2,t(3),q_f(3),'o');
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([0 t(3) -3 3]);
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
