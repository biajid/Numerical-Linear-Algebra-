f = @(x) x .^2 + 4 .* x + 5;
n = 100;

x_opt = zeros(n, 1);
dx = 0.01;
c = 0.1; % c is a constant ;

for index = 2 : n 
	slope = (f(x_opt(index - 1)) - f(x_opt(index - 1) - dx)) / dx;
	hessian = (f(x_opt(index - 1) - dx) - 2 * f(x_opt(index - 1)) + f(x_opt(index - 1) + dx)) / dx ^ 2;
	x_opt(index) = x_opt(index - 1) - (c  * slope) / hessian;
end

plot(1 : n, x_opt, 'Color', 'red', 'LineWidth', 2);
xlabel('Iteration.')
ylabel('Minimum Containing x.');
title("Newtons Method for the Optimization.")
