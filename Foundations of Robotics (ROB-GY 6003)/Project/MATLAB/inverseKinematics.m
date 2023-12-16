clear;
tic;
syms theta d a alpha q1 q2 q3 q4 q5 q6 px py pz r11 r12 r13 r21 r22 r23 r31 r32 r33
T06_E = [r11, r12, r13, px; r21, r22, r23, py; r31, r32, r33, pz; 0,0,0,1];
l1 = 10;
l2 = 20;
l3 = 15;
l4 = 15;
l5 = 5;
l6 = 20;

Thome = [0, -1,  0,  0;0,  0, -1,  0;1,  0,  0, 85; 0,  0,  0,  1];

i_1_T_i = matlabFunction([cos(theta), round(-cos(alpha), 3)*sin(theta), round(sin(alpha),3)*sin(theta), a*cos(theta); sin(theta), round(cos(alpha),3)*cos(theta), -round(sin(alpha),3)*cos(theta), a * sin(theta); 0, round(sin(alpha),3), round(cos(alpha),3), d; 0,0,0,1], 'Vars',[theta d a alpha]);
% i_1_T_i = matlabFunction([round(cos(theta), 3), round(-cos(alpha), 3)*round(sin(theta),3), round(sin(alpha),3)*round(sin(theta),3), a*round(cos(theta),3); round(sin(theta),3), round(cos(alpha),3)*round(cos(theta),3), -round(sin(alpha),3)*round(cos(theta),3), a * round(sin(theta),3); 0, round(sin(alpha),3), round(cos(alpha),3), d; 0,0,0,1], 'Vars',[theta d a alpha]);

T01 = i_1_T_i(((3*pi/2) + q1), l1, 0, 3*pi/2);
T12 = i_1_T_i(((3*pi/2)+q2), 0, l2, 0);
T23 = i_1_T_i(((pi/2)+q3), 0, 0, pi/2);
T34 = i_1_T_i(q4, l3+l4, 0, 3*pi/2);
T45 = i_1_T_i(((3*pi/2) + q5), 0, l5, 3*pi/2);
T56 = i_1_T_i(q6, 0, l6, 0);

% T01 = i_1_T_i(((0) + q1), 1, 0, pi/2);
% T12 = i_1_T_i(((pi/2) + q2), 0, 1, 0);
% T23 = i_1_T_i(((0) + q3), 0, 0, -pi/2);
% T34 = i_1_T_i(((0) + q4), 2, 0, pi/2);
% T45 = i_1_T_i(((0) + q5), 0, 1, -pi/2);
% T56 = i_1_T_i(((0) + q1), -1, 1, 0);

T06 = T01 * T12 * T23 * T34 * T45 * T56;
T06=simplify(T06);
% xE = px == T06(1,4);
% yE = py == T06(2,4);
% zE = pz == T06(3,4);
% nE = 1 == sqrt((T06(1,1)^2) + (T06(2,1)^2) + (T06(3,1)^2));
% sE = 1 == sqrt((T06(1,2)^2) + (T06(2,2)^2) + (T06(3,2)^2));
% aE = 1 == sqrt((T06(1,3)^2) + (T06(2,3)^2) + (T06(3,3)^2));
% ikEQ = T06_E == T06;
% S = solve(ikEQ, [q1 q2 q3 q4 q5 q6])

px = 0;
py = 0;
pz = 85;



% px=-1;
% py=1;
% pz=3;


Ttarget = [    1     0     0     0
     0    1     0     0
     0     0     1   100
     0     0     0     1];
Ttarget = round(Ttarget, 3);
% S = vpasolve([T06(1,4) ==px, T06(2,4) == py, T06(3,4) == pz, T06(1,1) == Thome(1,1), T06(2,2) == Thome(2,2), T06(3,3) == Thome(3,3) ], [q1 q2 q3 q4 q5 q6])
% S = vpasolve([T06(1,4) ==px, T06(2,4) == py, T06(3,4) == pz, T06(1,1) == 0.1, T06(2,2) == Thome(2,2), T06(3,3) == Thome(3,3) ], [q1 q2 q3 q4 q5 q6])
S = vpasolve([T06(1,4) == Ttarget(1,4), T06(2,4) == Ttarget(2,4), T06(3,4) == Ttarget(3,4), T06(1,1) == Ttarget(1,1), T06(2,2) == Ttarget(2,2), T06(3,3) == Ttarget(3,3)], [q1 q2 q3 q4 q5 q6])
% T06func = matlabFunction(T06, [q1 q2 q3 q4 q5 q6])
% S = fzero(T06 ==  desT, [0.1 0.1 0.1 0.1 0.1 0.1]);

disp(num2str(toc));