% We are trying to solve the differential equation given by, 
% dn/dt = f(t, n) = -0.8 * n ^ (3/2) + 10 * 2000 * (1 - exp(-3*t))
% We will use an implicit method to solve this differential equation.
% we will use Newton's method to solve the implicit equation at each time step.
% For using Newton's method, we would have 
% f = x + 0.8 * x ^ (3/2) * h - 10 * 2000 * (1 - exp(-3*t)) * h - xold;
% fprime = 1 + 0.8 * (3/2) * x ^ (1/2) * h;

a = 0; b = 0.5; h = 0.002;
N = floor((b - a) / h);
h = (b - a) / N;


t = zeros(1, N + 1);
y = zeros(1, N + 1);

t(1) = 0;
y(1) = 2000;

% Here, we define f and fprime for Newton's Method
f = @(x, xold, tt) x + 0.8 * x .^ (3/2) * h - 10 * 2000 * (1 - exp(-3 * tt)) * h - xold;
fprime = @(x) 1 + 0.8 * (3 / 2) * x .^ (1/2) * h;

for i = 1 : N 
    t(i + 1) = t(i) + h;
    xold = y(i);
    time = t(i + 1);

    fnew = @(x) f(x, xold, time);
    xnew = NewtonRoot(fnew, fprime, xold, 0.0001, 20);

    % Now put the solution on y;
    y(i + 1) = xnew;
end

plot(t, y, 'LineWidth', 2, 'Color', 'r');
grid on;
axis([a b 0 2500]);
xlabel('Time t');
ylabel('Solution y(t)');
title('Implicit Method Solution of dn/dt = -0.8 * n^{3/2} + 10 * 2000 * (1 - exp(-3*t))');