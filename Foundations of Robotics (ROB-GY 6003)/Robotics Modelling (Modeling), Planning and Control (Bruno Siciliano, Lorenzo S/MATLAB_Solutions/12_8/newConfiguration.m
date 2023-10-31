function  [qNew ,path , indexArrayUsedPrimitive, state] = newConfiguration( qRand, qNear, qGoal, motionPrimitiveCommandArray, indexArrayFreePrimitives, delta, threshold, robot, obs)

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

nPrimitives = size(motionPrimitiveCommandArray,1);
dist = inf;

% ode parameters
tSpan = [0 delta]; % solve from t=0 to t=delta
q0 = qNear;

% initialization
qNew = [];
path = [];
indexArrayUsedPrimitive = [];
indexSuccessfulPrimitive = [];

% loop
for i=1:nPrimitives
    
    if indexArrayFreePrimitives(i)==0 % the i-th motion primive has been already used from qNear
        continue;
    end
    
    % generate the i-th motion primitive
    v     = motionPrimitiveCommandArray(i,1);
    omega = motionPrimitiveCommandArray(i,2);
    [T Q] = ode45(@(t,q) unicycleKinematics( t, q, v ,omega ),tSpan,q0); % solve ODE
    
    % now Q represents the motion primitive path -> it is a sequence of configurations
    
    % check path for collisions
    if ~isCollisionFree(robot, obs, Q(end,:)) % if the last configuration of the path is not collision free
            indexArrayUsedPrimitive = [ i indexArrayUsedPrimitive]; % the i-th motion primitive brings to collision
            continue; % jump to next cycle 
    end
    pathLength = size(Q,1);
    collision = 0;
    for j=1:5:pathLength % check intermediate configurations
         qj = Q(j,:);
         if ~isCollisionFree(robot, obs, qj)
            collision = 1;
            break;
         end
    end
    if collision == 1
        indexArrayUsedPrimitive = [ i indexArrayUsedPrimitive]; % the i-th motion primitive brings to collision
        continue;
    end
    
    % compute the distance between the last configuration of the path, i.e. Q(end,:), 
    % and qRand and select the path which brings the robot closer to qRand
    d = distCspace( Q(end,:), qRand, robot.jointRanges);
    if d < dist
        qNew  = Q(end,:);
        dist = d;
        path = Q; 
        indexSuccessfulPrimitive = i; % the i-th motion primitive has been successfully used
    end
    
    
end


indexArrayUsedPrimitive = [ indexSuccessfulPrimitive indexArrayUsedPrimitive];

if  ~isempty(path)
    state = 'advanced';
    dist2qGoal = distCspace( qNew, qGoal, robot.jointRanges);
    if dist2qGoal < threshold
        fprintf(1,'dist to qGoal = %f\n',dist2qGoal);  
        state = 'reached';
    end
else
    state = 'trapped';
end


 
