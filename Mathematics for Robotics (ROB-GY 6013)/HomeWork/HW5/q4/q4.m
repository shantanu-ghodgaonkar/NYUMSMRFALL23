clear;
load('DataHW5_Prob4.mat');

S = eye(3);
tic;
nFinder = [transpose(C{1})];
for i = 2:1:N 
    if rank([nFinder, transpose(C{i})]) == size([nFinder, transpose(C{i})],2)
        nFinder = [nFinder, transpose(C{i})];
    end
end
n = rank(nFinder);

xHat = {0};
for k = n:1:N
    A = vertcat(C{1:k});
    %xHat{k} = ((transpose(A) * eye(k) * A)^(-1)) * (transpose(A) * eye(k) * A);
    xHat{k} = ((transpose(A) * A)^(-1)) * (transpose(A) * vertcat(y{1:k}));
end


%Ek using batch solution---------------------------------------------------
E1(1:n-1,1) = 0;
for k = n:1:N
    E1(k) = norm(xHat{k} - x_actual{k});
end
elapsedTime1 = toc;
%disp(['Elapsed Time to calculate Ek: ' num2str(elapsedTime1) ' seconds']);
% Plotting E{k} vs k
figure;  % Create a new figure window
scatter((1:1:N), E1, 'LineWidth', 2);  % Plot the data with a specified line width

% Customize the plot
msg = ['Elapsed Time to calculate Ek: ' num2str(elapsedTime1) ' seconds'];
text(250, 0.04, msg, 'FontSize', 12, 'Color', 'red');
title('Norm error in x-hat using Batch Process');
xlabel('k');        % Label for the x-axis
ylabel('E{k}');     % Label for the y-axis
grid on;            % Display grid lines

%Ek using RLS w/o MIL solution---------------------------------------------
tic;
[xHat_rlswmil, ~, ~, ~] = rlswomil(500, C, eye, y);
E2(1:n-1,1) = 0;
for k = n:1:N
    E2(k) = norm(xHat_rlswmil{k} - x_actual{k});
end
elapsedTime2 = toc;
%disp(['Elapsed Time to calculate Ek: ' num2str(elapsedTime2) ' seconds']);
% Plotting E{k} vs k
figure;  % Create a new figure window
scatter((1:1:N), E2, 'LineWidth', 2);  % Plot the data with a specified line width

% Customize the plot
msg = ['Elapsed Time to calculate Ek: ' num2str(elapsedTime2) ' seconds'];
text(250, 2.5, msg, 'FontSize', 12, 'Color', 'red');
title('Norm error in x-hat using RLS w/o MIL');
xlabel('k');        % Label for the x-axis
ylabel('E{k}');     % Label for the y-axis
grid on;            % Display grid lines

%Ek using RLS w/ MIL solution----------------------------------------------
tic;
[xHat_rlswmil, ~, ~, ~] = rlswmil(500, C, eye, y);
E3(1:n-1,1) = 0;
for k = n:1:N
    E3(k) = norm(xHat_rlswmil{k} - x_actual{k});
end
elapsedTime3 = toc;
%disp(['Elapsed Time to calculate Ek: ' num2str(elapsedTime3) ' seconds']);
% Plotting E{k} vs k
figure;  % Create a new figure window
scatter((1:1:N), E3, 'LineWidth', 2);  % Plot the data with a specified line width

% Customize the plot
msg = ['Elapsed Time to calculate Ek: ' num2str(elapsedTime3) ' seconds'];
% text(250, 0.04, msg, 'FontSize', 12, 'Color', 'red');
text(50, 0.8, msg, 'FontSize', 12, 'Color', 'red');
title('Norm error in x-hat using RLS w/ MIL');
xlabel('k');        % Label for the x-axis
ylabel('E{k}');     % Label for the y-axis
grid on;            % Display grid lines

disp(['Calculation using batch = ' num2str(elapsedTime1)]);
disp(['Calculation using batch = ' num2str(elapsedTime2)]);
disp(['Calculation using batch = ' num2str(elapsedTime3)]);

%--------------------------------------------------------------------------

%Function to define the Euclidean Norm
function scalar = eucNorm(ip1)
    sum = 0;
    for i=1:1:size(ip1,1)
        sum = sum + ip1(i,1)^2;
    end
    scalar = sqrt(sum);
end

%Function to recursively calculate xHat w/o Matrix Inversion Lemma
function [resXHat, Qk, Ck, Yk] = rlswomil(k, C, S, Y)
    if k == 1
        Qk = transpose(C{1}) * S * C{1};
        resXHat{1} = inv(Qk) * transpose(C{1}) * S * Y{1};
        Ck = C{1};
        Yk = Y{1};
    else 
        [resXHat, Qk_1, Ck_1, Yk_1] = rlswomil(k-1,C,S,Y);
        Ck = vertcat(Ck_1, C{k});
        Yk = vertcat(Yk_1, Y{k});
        Qk = Qk_1 + (transpose(Ck) * S * Ck);
        resXHat{k} = resXHat{k-1} + inv(Qk) * transpose(Ck) * S * (Yk - Ck * resXHat{k-1});
    end
end

%Function to recursively calculate xHat w/ Matrix Inversion Lemma
% function [resXHat, Pk, Ck, Yk] = rlswmil(k, C, S, Y)
%     if k == 1
%         Pk = inv(transpose(C{1}) * S * C{1});
%         resXHat{1} = Pk * transpose(C{1}) * S * Y{1};
%         Ck = C{1};
%         Yk = Y{1};
%     else 
%         [resXHat, Pk_1, Ck_1, Yk_1] = rlswmil(k-1,C,S,Y);
%         Ck = vertcat(Ck_1, C{k});
%         Yk = vertcat(Yk_1, Y{k});
%         Pk = Pk_1 - [Pk_1 * transpose(Ck)] * inv([[Ck * Pk_1 * transpose(Ck)] + inv(S)]) * [Ck * Pk_1];
%         resXHat{k} = resXHat{k-1} + Pk * transpose(Ck) * S * (Yk - Ck * resXHat{k-1});
%     end
% end
function [resXHat, Pk, Ck, Yk] = rlswmil(k, C, S, Y)
    if k == 1
        Pk = inv(transpose(C{1}) * S * C{1});
        resXHat{1} = Pk * transpose(C{1}) * S * Y{1};
        Ck = C{1};
        Yk = Y{1};
    else 
        [resXHat, Pk_1, Ck_1, Yk_1] = rlswmil(k-1,C,S,Y);
        Ck = vertcat(Ck_1, C{k});
        Yk = vertcat(Yk_1, Y{k});
        Pk = Pk_1 - Pk_1 * transpose(Ck) * inv( (Ck * Pk_1 * transpose(Ck)) + inv(S) ) * Ck * Pk_1;
        resXHat{k} = resXHat{k-1} + Pk * transpose(Ck) * S * (Yk - (Ck * resXHat{k-1}));
    end
end