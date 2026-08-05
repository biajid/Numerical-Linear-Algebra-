% Example 11-5: Solving a Boundary-Value Problem with Mixed Boundary Conditions
%
% Solve the following second-order boundary-value problem using the finite
% difference method:
%
%       -2*d^2y/dx^2 + y = exp(-0.2*x),
%
%       0 <= x <= 1
%
% subject to the mixed boundary conditions
%
%       y(0) = 1
%
%       dy/dx |_(x=1) = -y(1)
%
% Divide the solution domain [0, 1] into eight equally spaced subintervals.
%
% Approximate all derivatives using the central difference method and
% formulate the resulting system of finite difference equations.
%
% Solve the resulting linear system to obtain the numerical approximation
% of the solution at the grid points.
%
% Compare the numerical solution with the exact solution
%
%       y(x) = -0.2108*exp(x/sqrt(2))
%              + 0.1238*exp(-x/sqrt(2))
%              + exp(-0.2*x)/0.92
%
% Plot both the numerical and exact solutions on the same graph, and
% compare the accuracy of the finite difference approximation.
y_exact = @(x) -0.2108 .* exp(x ./ sqrt(2)) + 0.1238 .* exp(-x ./ sqrt(2)) + exp(-0.2 .* x) / 0.92;
x_exact = linspace(0, 1, 100);

y_values = y_exact(x_exact);

h = 0.1;
x = 0 : h : 1;


n = length(x) - 2;

d_diag = (4 + h ^ 2) .* ones(n, 1);
term2 = (4 + h ^ 2) - (8 / (2 * h + 3));
d_diag(end) = term2;

d_diag = diag(d_diag);

sub_diag1 = -2 .* ones(n - 1, 1);
term1 = (-2 + 2 / (2 * h + 3));
sub_diag1(end) = term1;
sub_diag = diag(sub_diag1, -1);

super_diag1 = -2 .* ones(n - 1, 1);
super_diag = diag(super_diag1, 1);



b = h .^ 2 * exp(-0.2 .* x(2 : end - 1));
b(1) = b(1) + 2;

A = d_diag + sub_diag + super_diag;

y_calculated = Tridiagonal(A, b);

yend = y_calculated(end - 1) * 1 / (-2 * h - 3) + 4 * y_calculated(end) / (3 + 2 * h);
y = [1; y_calculated; yend];

plot(x, y, 'k*', x_exact, y_values, 'color', 'red', 'LineWidth', 1.5);
legend('Numerical Solution', 'Exact Solution');
xlabel('x');
ylabel('y');
title('Comparison of Numerical and Exact Solutions');
