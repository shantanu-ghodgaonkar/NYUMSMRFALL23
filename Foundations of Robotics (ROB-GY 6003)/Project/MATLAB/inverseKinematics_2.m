clear;
tic;
% START FORWARD KINEMATICS-------------------------------------------------
syms theta d a alpha q1 q2 q3 q4 q5 q6
l1 = 10;
l2 = 20;
l3 = 15;
l4 = 15;
l5 = 5;
l6 = 20;
i_1_T_i = matlabFunction([cos(theta), round(-cos(alpha), 3)*sin(theta), round(sin(alpha),3)*sin(theta), a*cos(theta); sin(theta), round(cos(alpha),3)*cos(theta), -round(sin(alpha),3)*cos(theta), a * sin(theta); 0, round(sin(alpha),3), round(cos(alpha),3), d; 0,0,0,1], 'Vars',[theta d a alpha]);
T{01} = i_1_T_i(((3*pi/2) + q1), l1, 0, 3*pi/2);
T{12} = i_1_T_i(((3*pi/2)+q2), 0, l2, 0);
T{23} = i_1_T_i(((pi/2)+q3), 0, 0, pi/2);
T{34} = i_1_T_i(q4, l3+l4, 0, 3*pi/2);
T{45} = i_1_T_i(((3*pi/2) + q5), 0, l5, 3*pi/2);
T{56} = i_1_T_i(q6, 0, l6, 0);

T{06} = T{01} * T{12} * T{23} * T{34} * T{45} * T{56};

% END FORWARD KINEMATICS---------------------------------------------------

syms px py pz
Pn1 = T{06} * [0;0;0;1];
Pn = Pn1(1:3);
clear Pn1;
for i = 2:1:5
    T{str2num(strcat('0', num2str(i)))} = eye(4);
    for j=0:1:i-1
        T{str2num(strcat('0', num2str(i)))} = T{str2num(strcat('0', num2str(i)))} *  T{str2num(strcat(num2str(j), num2str(j+1)))};
    end
end

for i = 3:1:6
    T{str2num(strcat('1', num2str(i)))} = eye(4);
    for j=0:1:i-1
        T{str2num(strcat('1', num2str(i)))} = T{str2num(strcat('1', num2str(i)))} *  T{str2num(strcat(num2str(j), num2str(j+1)))};
    end
end




disp(num2str(toc));