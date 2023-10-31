%P10_5  Plots of Problem 10.5.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% error norm
  subplot(2,2,1);
  plot(time, sqrt(es(:,1).^2 + es(:,2).^2 + es(:,3).^2 + es(:,4).^2));
  axis([0 t_d 0 1.4])
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  title('error norm');
 
% image plane
  subplot(2,2,2);
  
  plot(sp0(1),sp0(2),'o');
  hold on
  plot(sp0(3),sp0(4),'o');

  plot(sp(1,1),sp(1,2),'x');
  plot(sp(:,1),sp(:,2));

  plot(sp(1,3),sp(1,4),'x');
  plot(sp(:,3),sp(:,4));

  axis([-0.3 0.3 -0.3 0.3]);
  axis('square');
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  title('image plane');

  figure
% camera position
  subplot(2,2,1);
  plot(time, xh(:,1),time,xh(:,2),time,xh(:,3));
  axis([0 t_d -0.2 0.8])
  p1 = text(0.03, 0.65,'z');
  p2 = text(0.03, 0.175,'y');
  p3 = text(0.03, -0.04,'x');
  %set(p1,'fontname','Times','fontsize',12,'fontweight','normal');
  %set(p2,'fontname','Times','fontsize',12,'fontweight','normal');
  %set(p3,'fontname','Times','fontsize',12,'fontweight','normal');
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[m]');
  title('pos');

  
% camera orientation
  subplot(2,2,2);
  plot(time, xh(:,4));
  axis([0 t_d -1.5 0])
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('orien');
