clear;

format short;
syms theta d a alpha q1 q2 q3 q4 q5 q6
l1 = 10;
l2 = 20;
l3 = 15;
l4 = 15;
l5 = 5;
l6 = 20;

i_1_T_i = matlabFunction([cos(theta), round(-cos(alpha), 3)*sin(theta), round(sin(alpha),3)*sin(theta), a*cos(theta); sin(theta), round(cos(alpha),3)*cos(theta), -round(sin(alpha),3)*cos(theta), a * sin(theta); 0, round(sin(alpha),3), round(cos(alpha),3), d; 0,0,0,1], 'Vars',[theta d a alpha]);

% T01 = i_1_T_i(3*pi/2, l1, 0, 3*pi/2);
% T12 = i_1_T_i(3*pi/2, 0, l2, 0);
% T23 = i_1_T_i(pi/2, 0, 0, pi/2);
% T34 = i_1_T_i(0, l3+l4, 0, 3*pi/2);
% T45 = i_1_T_i(3*pi/2, 0, l5, 3*pi/2);
% T56 = i_1_T_i(0, 0, l6, 0);

T{01} = i_1_T_i(((3*pi/2) + q1), l1, 0, 3*pi/2);
T{12} = i_1_T_i(((3*pi/2)+q2), 0, l2, 0);
T{23} = i_1_T_i(((pi/2)+q3), 0, 0, pi/2);
T{34} = i_1_T_i(q4, l3+l4, 0, 3*pi/2);
T{45} = i_1_T_i(((3*pi/2) + q5), 0, l5, 3*pi/2);
T{56} = i_1_T_i(q6, 0, l6, 0);
% T{01} = i_1_T_i(((0) + q1), 1, 0, pi/2);
% T{12} = i_1_T_i(((pi/2) + q2), 0, 1, 0);
% T{23} = i_1_T_i(((0) + q3), 0, 0, -pi/2);
% T{34} = i_1_T_i(((0) + q4), 2, 0, pi/2);
% T{45} = i_1_T_i(((0) + q5), 0, 1, -pi/2);
% T{56} = i_1_T_i(((0) + q1), -1, 1, 0);

T{06} = T{01} * T{12} * T{23} * T{34} * T{45} * T{56};
subs(T{06}, [q1 q2 q3 q4 q5 q6], [])
