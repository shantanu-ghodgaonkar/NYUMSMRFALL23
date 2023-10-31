function collision = isLinkBodyCollision(link, body)

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

nBodies = link.nBodies;

for iB = 1:nBodies
        %d(iB) = distBodyBody( link{iB}, body );
        collision = isBodyBodyCollision( link.bodyArray{iB}, body );
        
        if ( collision == true )
            return;
        end           
end

collision = false;

