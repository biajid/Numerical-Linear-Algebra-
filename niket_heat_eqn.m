n = 11;
d = zeros(n, 1);
super_diag = zeros(n - 1, 1);
sub_diag = zeros(n - 1, 1);
b = zeros(n, 1);

b(1) = 100;
b(end) = 25;
beta = -1;
alpha = 0.04;

super_diag(1) = 0;
sub_diag(end) = 0;

b(2 : end - 1) = beta;

d(1) = 1;
d(end) = 1;
d(2 : end -1) = -(2 + alpha);

sub_diag(1 : end - 1) = 1;
super_diag(2 : end) = 1;

A = diag(d) + diag(super_diag, 1) + diag(sub_diag, -1);

x = Tridiagonal(A, b);
plot(1 : length(x), x, 'r--', 'LineWidth', 2);
xlabel('Position [0, 1], discretized with 10 intervals.');
ylabel('Temperature');
title('Modeling Heat Equation: From Dr. Niket Kaisaire Lecture');

