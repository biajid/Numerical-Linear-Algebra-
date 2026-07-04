%We want to use Matlab's functions
%to find the roots of an equation
%We will use roots(p) and 
%fzeros(fun, [guess]);

%first equation :
% x .^ 3 - 3 .* x .^ 2 + 4 .* x - 2;
p = [1 -3 4 -2];
r = roots(p)


%Now we want to solve 
% x = exp(-ax) and a = 1/2;
f = @(x) x - exp(-a * x);
a = 1/2;
x0 = 0;


r1 = fzero(@(x) f(x), x0)

f = @(t) exp(-a * t ^ 2) - sin(t);
x0 = [0.75 0.9];
r2 = fzero(@(t) f(t), x0)


