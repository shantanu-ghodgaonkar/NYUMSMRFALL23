function [path, totalCost] = dijkstra(n, netCostMatrix, s, d)
% inspired by the function by Prof. David Johnson
% http://www.eng.utah.edu/~cs6370/Assignment4.html

% L. Villani, G. Oriolo, B. Siciliano
% February 2009

locked = false(1,n);
cost = inf * ones(1,n);
updated_by = zeros(1,n);

locked(s) = 1;
cost(s) = 0;
last = s;


while (~locked(d))
    remaining = find(~locked);

    for i = find(netCostMatrix(last,remaining) ~= 0)
                
        offer = cost(last) + netCostMatrix(last, remaining(i));
        if (offer < cost(remaining(i)))
            cost(remaining(i)) = offer;
            updated_by(remaining(i)) = last;
        end
    end
    
    [value, index] = min(cost(remaining));
    
    if (value < inf)
        last = remaining(index);
        locked(last) = true;
    else
        break;
    end
end


if (updated_by(d) ~= 0)
    totalCost = cost(d);

    last = d;
    path = [];
    while (last ~= 0)
        path = [last path];
        last = updated_by(last);
    end
else
    path = [];
    totalCost = inf;
end

