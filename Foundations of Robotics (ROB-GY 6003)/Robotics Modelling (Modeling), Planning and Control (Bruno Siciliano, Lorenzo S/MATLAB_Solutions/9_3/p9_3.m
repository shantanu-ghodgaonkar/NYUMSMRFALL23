%P9_3   Plots of Problem 9.3.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% position error in the base frame
  subplot(2,2,1)
  plot(time, e);
  axis([0 t_d -6e-2 6e-2]);
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[m]');
  title('pos error');
  pt(1) = text(1.5, 0.042,'x');
  pt(2) = text(1.5, -0.026,'y');

% contact force in the base frame
  subplot(2,2,2)
  plot(time, f_e);
  axis([0 t_d -550 550]);
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[N]');
  title('force');
  pt(3) = text(1.5, 235,'x');
  pt(4) = text(1.5, -100,'y');


% position error in the rotated base frame
  ec = e*R_c;
  subplot(2,2,3)
  plot(time, ec);
  axis([0 t_d -6e-2 6e-2]);
  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[m]');
  title('pos error');
  pt(5) = text(1.5, 0.007,'x_c');
  pt(6) = text(1.5, -0.043,'y_c');

% contact force in the rotated base frame
  f_ec = f_e*R_c;
  subplot(2,2,4)
  plot(time, f_ec);
  axis([0 t_d -550 550]);
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[N]');
  title('force');
  pt(7) = text(1.5, 60,'x_c');
  pt(8) = text(1.5, -170,'y_c');
  

   %for i=1:8,
   %    set(pt(i),'fontname','Times','fontsize',12,'fontweight','normal');
   %end