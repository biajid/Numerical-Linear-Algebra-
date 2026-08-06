% given equation y'' = 4 * y; y(0) = 1; y(1) = 3;
addpath('..');
h = 0.125 / 8;
t = 0 : h : 1;

n = length(t) - 2;
b = zeros(1, n);

b(1) = -1;
b(end) = -3;

d_diag = (-2 - 4 * h ^ 2) * ones(1, n);
s_subdiag = ones(1, n - 1);
s_superdiag = ones(1, n - 1);

A = diag(d_diag) + diag(s_subdiag, -1) + diag(s_superdiag, 1);
y_fd = tridiagonal(A, b);
rmpath('..');

y_fd = [1; y_fd; 3];

plot(t, y_fd, 'k', 'LineWidth', 1.5);
xlabel('t');
ylabel('y');
title('Finite Difference Solution');
grid on;
hold on;
% Use symbolic math to get the exact solution and draw the graph
syms Y(x)
cond1 = Y(0) == 1;
cond2 = Y(1) == 3;
y_exact = dsolve(diff(Y, x, 2) == 4 * Y, cond1, cond2);
tn = linspace(0, 1, 20);
y_exact_values = subs(y_exact, x, tn);
plot(tn, double(y_exact_values), 'r*', 'MarkerSize', 8, 'LineWidth', 2);
legend('Finite Difference', 'Exact Solution', 'location', 'best');
