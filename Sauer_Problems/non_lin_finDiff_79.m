% y'' = y - y .^ 2; y(0) = 1; y(1) = 4

t0 = 0; tf = 1;
global h; global ya; global yb;
h = 0.125 / 8;

n = round((tf - t0) / h);
h = (tf - t0) / n;

ya = 1; yb = 4;
nn = n - 1;
guess = zeros(nn, 1);

% x_n+1 = x_n - jac\f(x_n);
addpath('..');

for iter = 1 : 20
    xn = guess - tridiagonal(jac(guess) , f(guess));
    if norm(xn - guess) < 1e-3
        fprintf('Solution converged with %d iterations\n', iter);
        break;
    end
    guess = xn;
    if iter == 20
        error('Solution failed to converge')
    end 
end

y = [ya; guess; yb];
t = linspace(t0, tf, n + 1);

plot(t, y, 'color', 'red', 'LineWidth', 2);
xlabel('t');
ylabel('y');
title('Solution of a non linear boundary value problem with Finite Differences');
function out = jac(x)
    global h;
    n = length(x);
    d = (-2 - h ^ 2) + 2 .* h ^ 2 .* x;
    sb = ones(n - 1, 1);
    sp = ones(n - 1, 1);
    out = diag(d) + diag(sb, -1) + diag(sp, 1);
end

function out = f(x)
    global ya;
    global yb;
    global h;
    out = zeros(length(x), 1);
    out(1) = ya - (2 + h ^ 2) * x(1) + h ^ 2 * x(1) ^ 2 + x(2);
    %out(end) = x(end - 1) - (2 + h ^ 2) * x(end) + yb;
    out(2 : end - 1) = x(1 : end - 2) - (2 + h ^ 2) * x(2 : end - 1) + h ^ 2 .* x(2 : end - 1) .^ 2 + x(3 : end);
    out(end) = x(end - 1) ...
         - (2 + h^2)*x(end) ...
         + h^2*x(end)^2 ...
         + yb; 
end

