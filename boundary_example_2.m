% Problem:
%
% Solve the following linear boundary value problem using the
% Finite Difference Method.
%
% The differential equation is
%
%       d^2y
%       ---- = -4y + 4x
%       dx^2
%
% subject to the boundary conditions
%
%       y(0) = 0
%       y'(pi/2) = 0
%
% The exact solution of the problem is
%
%      y = x + 0.5 .* sin(2 .* x);
%
% Use the finite difference method to approximate the solution on the
% interval [0, pi/2].
%
% Repeat the computation for different numbers of grid points,
% where n ranges from 3 to 100.
%
% For each value of n, compute the approximate value of y(pi/2),
% compare it with the exact solution, and determine the absolute error.
%
% Finally, plot the error at the boundary point y(pi/2) versus
% the number of grid points n.

n = 20; % Here n is number of grid points.
h = (pi/2 - 0) / (n - 1);
x = 0 : h : pi/2;
y = zeros(length(x), 1);

y(1) = 0;
% given y'(pi/2) = 0. If I take backward difference formula, then 
% y(end - 1) - y(end) = 0; or y(end - 1) = y(end);
% so I need to solve for y(2) to y(end - 1)

% the equation : y(i - 1) + (-2 + 4 * h^2) * y(i) + y(i + 1) = 4 * x(i) *
% h^2;
% i moves from 2 to n-1.
c_diag = (-2 + 4 * h ^ 2) * ones(n - 2, 1);
c_diag(end) = c_diag(end) + 1;
A = diag(c_diag);
c_super_diag = ones(n - 3, 1);
c_super_diag = diag(c_super_diag, 1);
c_sub_diag = ones(n - 3, 1);
c_sub_diag = diag(c_sub_diag, -1);
A = A + c_sub_diag + c_super_diag;

b = 4 .* x(2 : end -1) .* h .^ 2;
dummy = tridiagonal(A, b);

y = [y(1); dummy; dummy(end)];

figure(1);
plot(x, y, 'r', 'LineWidth', 2);
hold on;
ynew = x + 0.5 .* sin(2 .* x);
plot(x, ynew, 'k', 'LineWidth', 2);
legend('Numerical Solution', 'Analytical Solution', 'location', 'best');
xlabel('x');
ylabel('y');
title('Plot of boundary value problems solution');

hold off;

% now we do the error plot:
f = @(x) x + 0.5 .* sin(2 .* x);
error_list = zeros(100 - 3 + 1, 1);
for n = 3 : 100
    h = (pi/2 - 0) / (n - 1);
    x = 0 : h : pi/2;
    y = zeros(length(x), 1);
    
    y(1) = 0;
    % given y'(pi/2) = 0. If I take backward difference formula, then 
    % y(end - 1) - y(end) = 0; or y(end - 1) = y(end);
    % so I need to solve for y(2) to y(end - 1)
    
    % the equation : y(i - 1) + (-2 + 4 * h^2) * y(i) + y(i + 1) = 4 * x(i) *
    % h^2;
    % i moves from 2 to n-1.
    c_diag = (-2 + 4 * h ^ 2) * ones(n - 2, 1);
    c_diag(end) = c_diag(end) + 1;
    A = diag(c_diag);
    c_super_diag = ones(n - 3, 1);
    c_super_diag = diag(c_super_diag, 1);
    c_sub_diag = ones(n - 3, 1);
    c_sub_diag = diag(c_sub_diag, -1);
    A = A + c_sub_diag + c_super_diag;
    
    b = 4 .* x(2 : end -1) .* h .^ 2;
    dummy = tridiagonal(A, b);
    
    y = [y(1); dummy; dummy(end)];
    error_list(n - 2) = y(end) - f(x(end));
end

figure(2);
semilogy(3 : 100, abs(error_list), 'Color', 'red', 'LineWidth', 2);
xlabel('Number of points');
ylabel('Error at the right end');
title('Error Plot');