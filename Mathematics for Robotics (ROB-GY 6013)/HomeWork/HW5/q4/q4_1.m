clear;
load('DataHW5_Prob4.mat');

S = eye(3);
tic;
xHat = {0};
for k = 1:1:N
    A = vertcat(C{1:k});
    %xHat{k} = ((transpose(A) * eye(k) * A)^(-1)) * (transpose(A) * eye(k) * A);
    xHat{k} = ((transpose(A) * A)^(-1)) * (transpose(A) * vertcat(y{1:k}));
end
%E(1:n-1,1) = 0;
for k = 1:1:N
    E(k) = norm(xHat{k} - x_actual{k});
end
elapsedTime = toc;
disp(['Elapsed Time to calcualte Ek: ' num2str(elapsedTime) ' seconds']);
% Plotting E{k} vs k
figure;  % Create a new figure window
scatter((1:1:N), E, 'LineWidth', 2);  % Plot the data with a specified line width

% Customize the plot
title('Norm error in x-hat using Batch Process');
xlabel('k');    % Label for the x-axis
ylabel('E{k}');    % Label for the y-axis
grid on;                   % Display grid lines
%legend('Sine Curve');       % Display legend


%--------------------------------------------------------------------------

%Function to define the Euclidean Norm
function scalar = eucNorm(ip1)
    sum = 0;
    for i=1:1:size(ip1,1)
        sum = sum + ip1(i,1)^2;
    end
    scalar = sqrt(sum);
end