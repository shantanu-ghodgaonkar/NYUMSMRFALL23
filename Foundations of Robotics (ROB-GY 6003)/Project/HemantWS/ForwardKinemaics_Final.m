clear;
clc;
%No of joints
n=6;
% PUT YOUR DH PARAMS HERE
dh=["3*pi/2","10","0","3*pi/2";
    "3*pi/2","0","20","0";
    "pi/2","0","0","pi/2";
    "0","30","0","3*pi/2";
    "3*pi/2","0","5","3*pi/2";
    "0","0","20","0"];
T={};
O={};
x=[];
y=[];
z=[];
for i=1:n        
    th0=str2num(dh(i,1));
    th=input(strcat("Enter Desired Angle on Joint ",num2str(i), " -->  "));
    d=str2num(dh(i,2));
    a=str2num(dh(i,3));
    al=str2num(dh(i,4));
    T{i}=[cos(th0+th),-cos(al)*sin(th0+th),sin(al)*sin(th0+th),a*cos(th0+th);
          sin(th0+th),cos(al)*cos(th0+th),-sin(al)*cos(th0+th),a*sin(th0+th);
          0,sin(al),cos(al),d;
          0,0,0,1];
    if i==1
        O{i}=T{i};
    else
        O{i}=O{i-1}*T{i};
    end
x(i)=round(O{i}(1,4),3);
y(i)=round(O{i}(2,4),3);
z(i)=round(O{i}(3,4),3);
end
x=[0,x];
y=[0,y];
z=[0,z];
plot3(x,y,z,"*-");
% axis([-5 5 -5 5 -5 5]);
Origins=[x;y;z]'
