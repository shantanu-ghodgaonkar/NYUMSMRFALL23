%P3_21  Plots of Problem 3.21.

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

% joint positions
  subplot(2,2,1);
  plot(time, q);

if c==1
  % constrained case
    pt(1) = text(1.0, 1.15,'1');
    pt(2) = text(1.0,-1.3,'2');
    pt(3) = text(1.0, -0.05,'3');
else
  % unconstrained case
    pt(1) = text(2.0, -0.25,'1');
    pt(2) = text(2.0, -2.0,'2');
    pt(3) = text(2.0,  1.35,'3');
end;

%  for i=1:3,
%      set(pt(i),'fontname','Times','fontsize',12,'fontweight','normal');
%  end

  axis([0 t_d -2.5 2.5]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad]');
  title('joint pos');

% joint velocities
  subplot(2,2,2);
  plot(time, dq);

if c==1
  % constrained case
    axis([0 t_d -5 5]);
    pt(1) = text(0.25, 1.5,'1');
    pt(2) = text(0.75, 1,'2');
    pt(3) = text(0.75, -1.5,'3');
else
  % unconstrained case
    axis([0 t_d -0.4 0.2]);
    pt(1) = text(1, -0.35,'1');
    pt(2) = text(1.5, 0.13,'2');
    pt(3) = text(0.4, 0.12,'3');
end;

%  for i=1:3,
%      set(pt(i),'fontname','Times','fontsize',12,'fontweight','normal');
%  end

%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[rad/s]');
  title('joint vel');

% position error norm
  subplot(2,2,3);
  plot(time, sqrt(e_p(:,1).^2 + e_p(:,2).^2));
  axis([0 t_d 0 6e-6]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[m]');
  title('pos error norm');

% distance
  subplot(2,2,4);
  plot(time, d_m);
  axis([0 t_d -0.15 0.15]);
%  set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
  xlabel('[s]');
  ylabel('[m]');
  title('distance');
