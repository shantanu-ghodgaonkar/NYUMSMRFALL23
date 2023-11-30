clc
close all
clear all
load('DataHW5_Prob4.mat');
%N=input('length of input sequence N = ');
t=[0:N-1];
ita=10^4;
I=ones(1,N);
R=ita*I;
w0=0.001;  phi=0.1;
%d=sin(2*pi*[1:N]*w0+phi);
d = x_actual;
%x=d+randn(1,N)*0.5;
x = y;
w=zeros(1,N); 

for i=1:N
   y(i) = w(i)' * x(i);
   e(i) = d(i) - y(i);
   z(i) = R(i) * x(i);
   q = x(i)' * z(i);
   v = 1/(1+q);
   zz(i) = v * z(i);
   w(i+1) = w(i) + e(i)*zz(i);
   R(i+1) = R(i) - zz(i)*z(i);
end
for i=1:N
yd(i) = sum(w(i)' * x(i));  
end
subplot(221),plot(t,d),ylabel('Desired Signal'),
subplot(222),plot(t,x),ylabel('Input Signal+Noise'),
subplot(223),plot(t,e),ylabel('Error'),
subplot(224),plot(t,yd),ylabel('Adaptive Desired output');