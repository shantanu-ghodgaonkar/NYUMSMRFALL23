%P4_7   Plots of Problem 4.7.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% x-position
%  subplot(4,2,1)
  subplot(3,2,1)
  plot(time,p(:,1))
  axis([t(1) t(2) -0.1 1.1]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  title('x-pos');
  xlabel('[s]');
  ylabel('[m]');

% y-position
%  subplot(4,2,2)
  subplot(3,2,2)
  plot(time,p(:,2));
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([t(1) t(2) -0.6 0.6]);
  title('y-pos');
  xlabel('[s]')
  ylabel('[m]')

% x-velocity
%  subplot(4,2,3)
  subplot(3,2,3)
  plot(time,dp(:,1));
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([t(1) t(2) -1 1]);
  title('x-vel');
  xlabel('[s]')
  ylabel('[m/s]')

% y-velocity
%  subplot(4,2,4)
  subplot(3,2,4)
  plot(time,dp(:,2));
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([t(1) t(2) -1 1]);
  title('y-vel');
  xlabel('[s]')
  ylabel('[m/s]')

% x-acceleration
%  subplot(4,2,5)
  subplot(3,2,5)
  plot(time,ddp(:,1));
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([t(1) t(2) -2 2]);
  title('x-acc');
  xlabel('[s]')
  ylabel('[m/s^2]')

% y-acceleration
%  subplot(4,2,6)
  subplot(3,2,6)
  plot(time,ddp(:,2));
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  axis([t(1) t(2) -2 2]);
  title('y-acc');
  xlabel('[s]')
  ylabel('[m/s^2]')

%set(1,'papertype','a4');
%set(1,'paperPosition',[0.25 0 16 12]);
%h = get(1,'Child');
%p = [0.2925 0.2925 0.16 0.17];
%set(h(1),'pos',p);
%p(1) = 0.065;
%set(h(2),'pos',p);
%p(1) = 0.2925;
%p(2) = 0.53;
%set(h(3),'pos',p);
%p(1) = 0.065;
%set(h(4),'pos',p);
%p(1) = 0.2925;
%p(2) = 0.7675;
%set(h(5),'pos',p);
%p(1) = 0.065;
%set(h(6),'pos',p);
