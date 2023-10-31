function [ dist , delta ] = connect( robot, obs, q1, q2, steps )

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

[ dist , delta ] = distCspace(q1, q2, robot.jointRanges);

% Do a linear interpolation along the line between q1 and q2
stepIncrement = 1.0/(steps-1);
for i = 0:stepIncrement:1
    qtest = q1 + i.*delta; 
    if ~isCollisionFree(robot, obs, qtest)
        dist = 0.0;
        return;
    end
end

