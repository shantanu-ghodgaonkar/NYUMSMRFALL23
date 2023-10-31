function [ dist , delta ] = distSO2( theta1, theta2)
% returns 
% dist  = the distance between two angles theta1 and theta2 in the space SO(2)
% delta = the shortest delta from theta1 to theta2 in SO(2)

%dist = min( abs(theta2-theta1) , 2*pi - abs(theta2-theta1) );

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

theta1 = wrap(theta1);
theta2 = wrap(theta2);


 
dist = abs(theta2-theta1);

if  dist > pi
    dist = 2*pi - dist;
    if theta1 > 0
        theta2 = theta2 + 2*pi;
    else
        theta2 = theta2 - 2*pi;
    end
end

delta  = theta2-theta1;


