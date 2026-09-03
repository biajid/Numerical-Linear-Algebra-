% In this code we will explore inverse transformation.
% We will first generate data with a known distribution, 
% convert it to standard uniform distribution through 
% inverse transformation, and then we will explore with 
% original parameter to see whether data follows 
% standard uniform.
% Then we will explore with wrong parameter, and will 
% note the effect. 

% First choose the number of observations
close; clear; clc;
N = 100000;
% set the parameters
lambda = 2;

% generate exponential random variables 
x = exprnd(1 / lambda, N, 1);
% apply the correct cdf
u_correct = 1 - exp(-lambda .* x);




figure('Name', 'Correct Normalized pdf');


histogram(u_correct, 40, 'Normalization', 'pdf');



xlabel('u');
ylabel('Estimated Density');
title('Corrected CDF: U = F_X(X)');
hold on;
yline(1, '--', 'uniform(0, 1) pdf');
hold off;

% Now, we will apply the wrong parameter to see the effect
wrong_lambda = 1; 
u_wrong = 1 - exp(-wrong_lambda .* x);
figure('Name', 'Wrong Normalized pdf');
histogram(u_wrong, 40, 'Normalization', 'pdf');
xlabel('u');
ylabel('Estimated Density');
title('Incorrect CDF: U = F_X(X) with Wrong Parameter');
hold on;
yline(1, '--', 'uniform(0, 1) pdf');
hold off;
