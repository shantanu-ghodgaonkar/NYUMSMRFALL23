%P8_11  Plots of Problem 8.11.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if c==0,
% joint torques
  subplot(2,2,1)
  plot(time, tau(:,1),time,tau(:,2),'--');
  axis([0 t_d -4000 4000]);
   set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[Nm]');
  title('joint torques');

% joint position errors
  subplot(2,2,3)
  plot(time, (q_d(:,1)-q(:,1)),time, (q_d(:,2)-q(:,2)),'--');
  axis([0 t_d -0.05 0.05]);
   set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('joint pos errors');

else

% joint torques
  subplot(2,2,2)
  plot(time, tau(:,1),time,tau(:,2),'--');
  axis([0 t_d -4000 4000]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[Nm]');
  title('joint torques');

% joint position errors
  subplot(2,2,4)
  plot(time, (q_d(:,1)-q(:,1)),time, (q_d(:,2)-q(:,2)),'--');
  axis([0 t_d -0.05 0.05]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('joint pos errors');

end;
