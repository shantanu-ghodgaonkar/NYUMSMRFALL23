function collision = isBodyBodyCollision(b1, b2)

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

% body.boundingBox = [xMin yMin; 
%                     xMax yMax;]
x1Min = b1.boundingBox(1,1); y1Min = b1.boundingBox(1,2);
x1Max = b1.boundingBox(2,1); y1Max = b1.boundingBox(2,2);

x2Min = b2.boundingBox(1,1); y2Min = b2.boundingBox(1,2);
x2Max = b2.boundingBox(2,1); y2Max = b2.boundingBox(2,2);

checkXMin = (x1Min >= x2Min ) |  (x1Min <= x2Max );
checkXMax = (x1Max >= x2Min ) |  (x1Max <= x2Max );

checkYMin = (y1Min >= y2Min ) |  (y1Min <= y2Max );
checkYMax = (y1Max >= y2Min ) |  (y1Max <= y2Max );

if ( (checkXMin || checkXMax) &&  (checkYMin || checkYMax) )
    % the two bounding boxes intersect 
    dist = distBodyBody(b1,b2);
    if dist > 0.0
        collision = false;
    else
        collision = true;
    end 
else
    % the two bounding boxes does not intersect
    collision = false;
end
    
