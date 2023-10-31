% p11_13   Plots of Solution to Problem 11.13

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

hold off
clf

figure(1);
%subplot(2,2,1)
hold on;
axis equal;
%set(gca,'fontname','Times','fontsize',12,'fontweight','normal');box on;

%setup unicycle shape

unicycle_size=0.1
vertices_unicycle_shape=unicycle_size*[[-0.25;-0.5;1/unicycle_size],...
    [0.7;0;1/unicycle_size],[-0.25;0.5;1/unicycle_size]];
faces_unicycle_shape=[1 2 3];

%plot unicycle initial configuration

M=[cos(theta_i) -sin(theta_i) x_i; sin(theta_i) cos(theta_i)  y_i;0 0 1]; 
vertices_unicycle_shape_i=(M*vertices_unicycle_shape)';
vertices_unicycle_shape_i=vertices_unicycle_shape_i(:,1:2);

patch('Faces',faces_unicycle_shape,'Vertices',vertices_unicycle_shape_i,...
    'FaceColor','none','EdgeColor','k','EraseMode','none');

%plot unicycle final configuration

M=[cos(theta_f) -sin(theta_f) x_f; sin(theta_f) cos(theta_f)  y_f;0 0 1];
vertices_unicycle_shape_f=(M*vertices_unicycle_shape)';
vertices_unicycle_shape_f=vertices_unicycle_shape_f(:,1:2);
patch('Faces',faces_unicycle_shape,'Vertices',vertices_unicycle_shape_f,'FaceColor','none','EdgeColor','k','EraseMode','none');

%plot trajectory

plot(x,y,'k')
xlabel('[m]');ylabel('[m]');

range=axis;
incr=0.03
range(1)=range(1)-(range(2)-range(1))*incr;
range(2)=range(2)+(range(2)-range(1))*incr;
range(3)=range(3)-(range(4)-range(3))*incr;
range(4)=range(4)+(range(4)-range(3))*incr;
axis(range);
axis equal
range=axis; 

%plot geometric inputs

figure(2);
%subplot(4,2,1); hold on;
subplot(2,1,1); hold on;
%set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
plot(s,tildev,'k');
ylabel('[m]');
title('tilde v(s)')
box on;

%subplot(4,2,3); hold on;
subplot(2,1,2); hold on;
%set(gca,'fontname','Times','fontsize',12,'fontweight','normal');
plot(s,tildeomega,'k')
ylabel('[rad]');
title('tilde omega(s)')
box on;



