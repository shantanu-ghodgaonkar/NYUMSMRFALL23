%P8_10  Plots of Problem 8.10.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if c==0,
% joint positions
  subplot(2,2,1);
  plot(time, q_d(1)*ones(size(time)),'--',time,q(:,1));
  axis([0 t_d 0.6 0.85])
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('joint 1 pos');

  subplot(2,2,2);
  plot(time, q_d(2)*ones(size(time)),'--',time,q(:,2));
  axis([0 t_d -1.75 -1.5])
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('joint 2 pos');

else

% joint positions
  subplot(2,2,1);
  plot(time, q_d(1)*ones(size(time)),'--',time,q(:,1));
  axis([0 t_d -3.35 -3.1])
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('joint 1 pos');

  subplot(2,2,2);
  plot(time, q_d(2)*ones(size(time)),'--',time,q(:,2));
  axis([0 t_d -2.55 -2.3])
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('joint 2 pos');

end;
