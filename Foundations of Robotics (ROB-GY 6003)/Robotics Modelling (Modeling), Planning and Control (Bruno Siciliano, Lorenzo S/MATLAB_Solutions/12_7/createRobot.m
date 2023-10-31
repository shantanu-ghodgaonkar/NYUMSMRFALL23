function robot = createRobot(linkArray, jointArray, jointRanges)
%-Link Structure (or base structure)
% link.bodyArray
% link.nBodies
%-Robot structure-   
% robot.q
% robot.linkArray
% robot.nLinks
% robot.jointArray
% robot.jointRanges

% L. Villani, G. Oriolo, B. Siciliano
% February 2009


robot.linkArray = linkArray;
robot.nLinks = length(linkArray);
for i=1:robot.nLinks
     robot.linkArray{i}.nBodies = length(linkArray{i}.bodyArray);  
end

[nJoints, nColumns] = size(jointArray);
if robot.nLinks ~= nJoints
    error('number of links and number of joints must be the same');
end
robot.jointArray = jointArray;

[nRowsJointRange, nColumns] = size(jointRanges);
if (nRowsJointRange-2) ~= nJoints
    error('the dimension of the jointLimit vector is not correct');
end
robot.jointRanges = jointRanges;

q = zeros(1,robot.nLinks+2);
robot.positionedLinkArray = forwardKinematics(robot,q);
