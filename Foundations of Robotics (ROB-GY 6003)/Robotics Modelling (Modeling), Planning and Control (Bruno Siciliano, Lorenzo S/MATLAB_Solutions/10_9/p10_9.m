%P10_9  Plots of Problem 10.9.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009


% desired camera position and orientation with respect to the base frame
  o_do = x_do(1:3);
  phi_do = x_do(4);

  o_o = x_o(1:3);
  phi_o = x_o(4);

  phi_d = phi_o - phi_do;
  R_d = [cos(phi_d) -sin(phi_d) 0; sin(phi_d) cos(phi_d) 0; 0 0 1];

  x_d(1:3) = o_o - R_d*o_do;
  x_d(4) = phi_d;

% camera x-position
  subplot(2,2,1);
  plot(time, x_d(1)*ones(size(time)),'--',time,xc(:,1));
  axis([0 t_d 0.975 1.425])
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[m]');
  title('x-pos');

% camera y-position
  subplot(2,2,2);
  plot(time, x_d(2)*ones(size(time)),'--',time,xc(:,2));
  axis([0 t_d 0.975 1.425])
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[m]');
  title('y-pos');

% camera z-position
  subplot(2,2,3);
  plot(time, x_d(3)*ones(size(time)),'--',time,xc(:,3));
  axis([0 t_d 0.075 0.525])
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[m]');
  title('z-pos');
  
% camera orientation
  subplot(2,2,4);
  plot(time, x_d(4)*ones(size(time)),'--',time,xc(:,4));
  axis([0 t_d 0.5 2])
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('alpha');

% desired feature vectors
  s_pd = features_p(x_do);
  s_d = features_l(s_pd);

figure
% feature vector components
  subplot(221)
  plot(time,s);
  hold on 
  plot(time,s_d*ones(1,size(time,1)),'--');
  axis([0 t_d -1.2 0.4])
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  title('param');


% image plane
  subplot(2,2,2);
  plot(s_pd(1),s_pd(2),'o');
  hold on
  plot(s_pd(3),s_pd(4),'o');

  plot(s_p(1,1),s_p(1,2),'x');
  plot(s_p(:,1),s_p(:,2));

  plot(s_p(1,3),s_p(1,4),'x');
  plot(s_p(:,3),s_p(:,4));

  axis([-0.3 0.3 -0.3 0.3]);
  axis('square');
  %set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  title('image plane');
