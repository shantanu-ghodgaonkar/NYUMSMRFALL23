clear;
clc;

tic;
syms theta d a alpha q1 q2 q3 q4 q5 q6 px py pz
l1 = 1;
l2 = 1;
l3 = 1;
l4 = 1;
l5 = 1;
l6 = 1;

% i_1_T_i = matlabFunction([cos(theta), -cos(alpha)*sin(theta), sin(alpha)*sin(theta), a*cos(theta); sin(theta), cos(alpha)*cos(theta), -sin(alpha)*cos(theta), a * sin(theta); 0, sin(alpha), cos(alpha), d; 0,0,0,1], 'Vars',[theta d a alpha]);

i_1_T_i = matlabFunction([round(cos(theta), 3), round(-cos(alpha), 3)*round(sin(theta),3), round(sin(alpha),3)*round(sin(theta),3), a*round(cos(theta),3); round(sin(theta),3), round(cos(alpha),3)*round(cos(theta),3), -round(sin(alpha),3)*round(cos(theta),3), a * round(sin(theta),3); 0, round(sin(alpha),3), round(cos(alpha),3), d; 0,0,0,1], 'Vars',[theta,d,a,alpha]);

% T01 = i_1_T_i(0+q1,1,0,pi/2);
% T12 = i_1_T_i((pi/2)+q2,0,1,0);
% T23 = i_1_T_i(0+q3,0,2,-pi/2);
% T34 = i_1_T_i(0+q4,0,0,pi/2);
% T45 = i_1_T_i(0+q5,0,1,-pi/2);
% T56 = i_1_T_i(0+q6,-1,0.5,0);

T01 = i_1_T_i(((3*pi/2) + q1), l1, 0, 3*pi/2);
T12 = i_1_T_i(((3*pi/2)+q2), 0, l2, 0);
T23 = i_1_T_i(((pi/2)+q3), 0, 0, pi/2);
T34 = i_1_T_i(q4, l3+l4, 0, 3*pi/2);
T45 = i_1_T_i(((3*pi/2) + q5), 0, l5, 3*pi/2);
T56 = i_1_T_i(q6, 0, l6, 0);

T06 = T01 * T12 * T23 * T34 * T45 * T56;


T=[];
Q={};
O={};
O1=[];
Q1=[];
% O{1}=[];
c=1;
for t1=0:30:90 %37
    r1=deg2rad(t1);
    for t2=0:30:360 %19
        r2=deg2rad(t2);
        for t3=0:30:360 %10
            r3=deg2rad(t3);
            % % Q{c}=[r1,r2,r3];
            %             T=subs(T03,[q1,q2,q3],[r1,r2,r3]);
            % 
            %                 % O{c}=double(T(1:3,4)');
            %                 O1=[O1;double(T(1:3,4)')];
            %                 Q1=[Q1;r1,r2,r3];
                        % c=c+1
            for t4=0:30:360 %19
                r4=deg2rad(t4);
                for t5=0:30:360 %13
                    r5=deg2rad(t5);
                    for t6=0:30:360 %25
                        r6=deg2rad(t6);
                        % Q{c}=[r1,r2,r3,r4,r5,r6];
                        T=subs(T06,[q1,q2,q3,q4,q5,q6],[r1,r2,r3,r4,r5,r6]);
                        if T(3,4) >= 0
                            O1=[O1;double(T(1:3,4)')];
                            Q1=[Q1;r1,r2,r3,r4,r5,r6];
                        c=c+1
                        end
                    end
                end
            end
        end
    end
end
toc
