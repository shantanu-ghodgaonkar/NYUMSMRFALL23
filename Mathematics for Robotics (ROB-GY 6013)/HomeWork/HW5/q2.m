A = [1,0,sqrt(2); 0,2,0;sqrt(2),0,0];
[eVec, eVal] = eig(A);
v1 = [0;1;0];
v2 = [1;0;0];
v3 = [0;0;1];
o = [v1,v2,v3];

if eVec^-1 == transpose(eVec)
    disp("eVec is Orthogonal")
else 
    disp("eVec is Not Orthogonal")
end

if o^-1 == transpose(o)
    disp("o is Orthogonal")
else 
    disp("o is Not Orthogonal")
end

if A == (o * eVal* transpose(o))
    disp("TRUE")
else
    disp("FALSE");
    (o * eVal* transpose(o))
end