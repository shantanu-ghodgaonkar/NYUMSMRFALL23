function [ dist , delta] = distCspace ( q1 , q2 , jointLimits )
% Compute the distance in the configuration space between q1 and q2
% The robot is a sequence of links connected by joints.
% The first joint is a translational+rotational joint which defines the first link configuration (x_1 y_1 q_1). 
% The other joints are purely rotational (q_i, i>1). 
% Hence, a robot configuration is q = [x_1 y_1 q_1 q_2 ... q_n].
%
% inputs:
% q1 , q2  two configurations
% jointLimits = [x_1Min x_1Max; y_1Min y_1Max; q_1Min q_1Max; q_2Min q_2Max;...; q_nMin q_nMax];
%
% outputs:
% dist   = distance between q1 and q2 in the C-space manifold
% delta  = the shortest vector from q1 to q2 in the C-space manifold

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

c1 = 1; % weight for the euclidean space projection metric
c2 = 1; % weight for the joint space projection metric

%% Compute the component distance in the euclidean space projection IR^2

distIR2 = norm( q2(1:2) - q1(1:2), 2 );
deltaIR2 = q2(1:2) - q1(1:2); % the direction of the shortest path between q1 and q2 in the euclidean projection

%% Compute the component distance in the joint space projection

nJoints = length(q1) - 2;
jointLimits = jointLimits(3:end,:); % -> now it is jointLimits = [q_1Min q_1Max; q_2Min q_2Max; ...; q_nMin q_nMax];

d = zeros(1,nJoints);           
deltaJoint = zeros(1,nJoints); % the shortest vector from q1 to q2 in the joint space manifold

for i=1:nJoints
    if abs(jointLimits(i,2)-jointLimits(i,1)) >= 2*pi % if |q_iMax - q_iMin| >= 2*pi  
        [ d(i)  deltaJoint(i) ] = distSO2(q1(i+2),q2(i+2)); % compute the distance in the SO(2) manifold
    else
        d(i) = abs(q2(i+2)-q1(i+2)); % compute the distance in the admissible interval [qiMin , qiMax] which is strictly contained in [-pi,pi]
        deltaJoint(i) = q2(i+2)-q1(i+2);
    end
end
distJoint = norm(d,2); % compute the L2 norm in the joint space

%% Compute the distance in the total C-space

dist  = c1*distIR2 + c2*distJoint;
delta = [ deltaIR2 deltaJoint ];

