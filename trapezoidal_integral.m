function out = trapezoidal_integral(fun, a, b, N)
% This function performs trapezoidal integration on the function handle, f,
% within the interval [a, b] by taking equispaced N subintervals. 
% Argument's required: function_handle, lower bound, upperbound, number of
% subintervals.

h = (b - a) / N;
x = a : h : b;
f = fun(x);

out = 0.5 * h * (f(1) + f(end)) + h * sum(f(2 : end - 1));
end
