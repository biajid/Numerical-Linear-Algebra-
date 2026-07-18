% Problem:
%
% Solve the rocket trajectory problem using the Finite Difference Method.
%
% The altitude of the rocket, y(t), satisfies the second-order ordinary
% differential equation
%
%       d^2y
%       ---- = -g
%       dt^2
%
% where g is the acceleration due to gravity.
%
% The boundary conditions are
%
%       y(0) = 0
%       y(5) = 50
%
% Divide the interval [0, 5] into n = 10 equal subintervals and use the
% finite difference method to approximate the altitude of the rocket at
% the grid points.
%
% Finally, plot the altitude of the rocket as a function of time after
% launch.
n = 20;
h = (5 - 0) / n;
g = 9.8;
y = zeros(1, n + 1);

y(end) = 50;

c_diag = -2 * ones(n - 1, 1);
A = diag(c_diag);
c_super_diag = ones(n - 2, 1);
c_super_diag = diag(c_super_diag, 1);
c_sub_diag = ones(n - 2, 1);
c_sub_diag = diag(c_sub_diag, -1);

A = A + c_sub_diag + c_super_diag;

b = -g * h ^ 2 * ones(n - 1, 1);
b(end) = b(end) - 50;

dummy = tridiagonal(A, b);


y = [y(1); dummy; y(end)];
x = 0 : h : 5;
figure(3);
plot(x, y, 'Color', 'red', 'LineWidth', 2);
xlabel('Time');
ylabel('Position');
title('Boundary Value Problem Solution');

% check initial velocity:
y0 = -9.8 * h ^ 2 + 2 * y(1) - y(2);
yprime1 = (y(2) - y0) / (2 * h)

