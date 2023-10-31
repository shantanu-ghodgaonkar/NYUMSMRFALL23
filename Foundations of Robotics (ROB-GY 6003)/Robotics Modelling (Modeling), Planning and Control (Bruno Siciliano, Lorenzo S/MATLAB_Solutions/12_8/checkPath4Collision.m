function collision = checkPath4Collision(path, robot,obs)    

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

pathLength = size(path,1);
collision = 0;

for j=1:pathLength
     qj = path(j,:);
     if ~isCollisionFree(robot, obs, qj)
        collision = 1;
        break;
     end
end