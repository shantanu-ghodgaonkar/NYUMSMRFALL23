function  positionedLinkArray  = forwardKinematics( robot, q )

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

if ( length(q) ~= (robot.nLinks+2) )
    error('input configuration dimension is not correct')
end

nLinks=robot.nLinks;

x = q(1);
y = q(2);

Rotation = eye(3);   % total rotation matrix
Translation = [x y]; % total translation vector

positionedLinkArray = robot.linkArray;

for i = 1:nLinks
    Translation = robot.jointArray(i,:) * Rotation(1:2,1:2)' + Translation;
    jointRotation = rotationMatrixOz(q(i+2));
    Rotation = Rotation * jointRotation;

    nLinkBodies = positionedLinkArray{i}.nBodies;
    for j=1:nLinkBodies
        [nBodyPoints,nColumns] = size(robot.linkArray{i}.bodyArray{j}.pointArray);
        positionedLinkArray{i}.bodyArray{j}.pointArray = robot.linkArray{i}.bodyArray{j}.pointArray * Rotation(1:2,1:2)' + ones(nBodyPoints,1)*Translation;
    end
end



