clear;
load('DataHW5_Prob5.mat');

S = eye(3);
lam = 0.98;


tic;
nFinder = [transpose(C{1})];
for i = 2:1:N 
    if rank([nFinder, transpose(C{i})]) == size([nFinder, transpose(C{i})],2)
        nFinder = [nFinder, transpose(C{i})];
    end
end
n = rank(nFinder);

%Ek using batch solution w/o lambda----------------------------------------
xHat = {0};
for k = n:1:N
    A = vertcat(C{1:k});
    % Rk = [];
    % for i = 1:1:k
    %     Rk = blkdiag(Rk, (lam^(k-i)) * S);
    % end
    Rk = eye;
    %xHat{k} = ((transpose(A) * eye(k) * A)^(-1)) * (transpose(A) * eye(k) * A);
    xHat{k} = ((transpose(A) * Rk * A)^(-1)) * (transpose(A) * Rk * vertcat(y{1:k}));
end
E1(1:n-1,1) = 0;
for k = n:1:N
    E1(k) = norm(xHat{k} - x_actual{k});
end
elapsedTime0 = toc;
%disp(['Elapsed Time to calculate Ek: ' num2str(elapsedTime1) ' seconds']);
% Plotting E{k} vs k
figure;  % Create a new figure window
scatter((1:1:N), E1, 'LineWidth', 2);  % Plot the data with a specified line width

% Customize the plot
msg = ['Elapsed Time to calculate Ek: ' num2str(elapsedTime0) ' seconds'];
text(50, 1.2, msg, 'FontSize', 12, 'Color', 'red');
title('Norm error in x-hat using Batch Process w/o lambda');
xlabel('k');        % Label for the x-axis
ylabel('E{k}');     % Label for the y-axis
grid on;            % Display grid lines


%Ek using batch solution w/ lambda-----------------------------------------
xHat = {0};
for k = n:1:N
    A = vertcat(C{1:k});
    % Rk = [];
    % for i = 1:1:k
    %     Rk = blkdiag(Rk, (lam^(k-i)) * S);
    % end
    Rk = rKcalc(k, lam, S);
    %xHat{k} = ((transpose(A) * eye(k) * A)^(-1)) * (transpose(A) * eye(k) * A);
    xHat{k} = ((transpose(A) * Rk * A)^(-1)) * (transpose(A) * Rk * vertcat(y{1:k}));
end
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
text(250, 0.15, msg, 'FontSize', 12, 'Color', 'red');
title('Norm error in x-hat using Batch Process w/ lambda');
xlabel('k');        % Label for the x-axis
ylabel('E{k}');     % Label for the y-axis
grid on;            % Display grid lines

%Ek using RLS w/o MIL solution---------------------------------------------
tic;
[xHat_rlswmil, ~, ~, ~] = rlswomil(500, C, eye, y, lam);
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
text(100, 1400, msg, 'FontSize', 12, 'Color', 'red');
title('Norm error in x-hat using RLS w/o MIL w/ lambda');
xlabel('k');        % Label for the x-axis
ylabel('E{k}');     % Label for the y-axis
grid on;            % Display grid lines


disp(['Calculation using batch = ' num2str(elapsedTime0)]);
disp(['Calculation using batch = ' num2str(elapsedTime1)]);
disp(['Calculation using batch = ' num2str(elapsedTime2)]);

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
function [resXHat, Qk, Ck, Yk, Rk] = rlswomil(k, C, S, Y, lam)
    if k == 1
        Rk = eye(3);
        Qk = transpose(C{1}) * Rk * C{1};
        resXHat{1} = inv(Qk) * transpose(C{1}) * Rk * Y{1};
        Ck = C{1};
        Yk = Y{1};
    else 
        [resXHat, Qk_1, Ck_1, Yk_1, Rk_1] = rlswomil(k-1,C,S,Y, lam);
        Ck = vertcat(Ck_1, C{k});
        Yk = vertcat(Yk_1, Y{k});
        Rk = blkdiag(lam * Rk_1, eye(3));
        Qk = Qk_1 + (transpose(Ck) * Rk * Ck);
        resXHat{k} = resXHat{k-1} + inv(Qk) * transpose(Ck) * Rk * (Yk - Ck * resXHat{k-1});
    end
end

%Function to recursively calculate Rk
function Rk = rKcalc(k, lam, S)
    if(k == 1)
        Rk =  (lam^(k-1)) * S;
    else
        Rk = blkdiag((lam^(k-1)) * S, rKcalc(k-1, lam, S));
    end
end