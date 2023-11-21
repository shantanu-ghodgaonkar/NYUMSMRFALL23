clear
load("HW4_Prob5.mat")
ndy = diff(y)./diff(t);
ndy(1501,1) = 0;

figure
plot(t,dy)
title('Prob 5 (a) - True Derivative')
xlabel('t')
ylabel('Derivative of y')

figure
plot(t,ndy)
title('Prob 5 (a) - Naive Derivative')
xlabel('t')
ylabel('Derivative of y')

figure
plot(t,dy)
title('Prob 5 (a) - True and Naive Derivative')
xlabel('t')
ylabel('Derivative of y')
hold on
plot(t,ndy)
legend('True derivative','Naive Derivative')
hold off