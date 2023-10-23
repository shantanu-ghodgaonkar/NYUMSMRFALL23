%Create the robot
robot = rigidBodyTree;

%Creating the first link, attached to the base
body1 = rigidBody('body1');
jnt1 = rigidBodyJoint('jnt1','revolute');
jnt1.HomePosition = 0;
jnt1.JointAxis = [0,0,1];
setFixedTransform(jnt1,trvec2tform([0, 0, 0]));
body1.Joint = jnt1;
addBody(robot,body1,'base')

%Creating the second link, attached to the first link
body2 = rigidBody('body2');
jnt2 = rigidBodyJoint('jnt2','revolute');
jnt2.HomePosition = 0;
jnt2.JointAxis = [0,0,1];
setFixedTransform(jnt2,trvec2tform([1, 0, 0]));
body2.Joint = jnt2;
addBody(robot,body2,'body1'); % Add body2 to body1

%Creating the end effector, attached to the second link
bodyEndEffector = rigidBody('endeffector');
setFixedTransform(bodyEndEffector.Joint,trvec2tform([0.5, 0, 0]));
addBody(robot,bodyEndEffector,'body2');

%Displaying created robot
config = randomConfiguration(robot)
tform = getTransform(robot,config,'endeffector','base')
showdetails(robot);
show(robot);
%{
syms theta1 theta2
T1 = [cos(theta1) -sin(theta1) 0 cos(theta1)
    sin(theta1) cos(theta1) 0 sin(theta1)
    0 0 1 0
    0 0 0 1];
T2 = [cos(theta2) -sin(theta2) 0 0.5*cos(theta2)
    sin(theta2) cos(theta2) 0 0.5*sin(theta2)
    0 0 1 0 
    0 0 0 1];
T = T1*T2;
theta1_range = linspace(0,pi, 180);
theta2_range = linspace(-pi/2,pi, 270);
test_map = containers.Map({'theta1', 'theta2'},{theta1_range,theta2_range});
plot2dworkspace(T, test_map);
%}

%{
a1 = 1; 
a2 = 0.5;
DH(1) = Link([0 0 a1 0]);
DH(2) = Link([0 0 a2 0]);
th1 = (0:0.0005:pi) ;
th2 = (-pi/2:0.0005:pi);
q = {th1,th2};
plotworkspace(DH,q)
%}
