%P5_3   Plots of Problem 5.3.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if c==0
% current
  subplot(2,2,1)
  plot(time, curr);
  axis([0 t_d 0 2]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[A]');
  title('current');

else

% velocity
  subplot(2,2,2)
  plot(time, omega);
  axis([0 t_d 0 25]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad/s]');
  title('velocity');

end;
