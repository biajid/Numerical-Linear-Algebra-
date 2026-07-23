function out = simpson_one_third(fun, a, b, N)
% This function performs Simpson's 1/3 rule to do the integration on
% function f on the interval [a, b]. 
% The number of interval must be an even number. 
% Argument required: function_hanlde, lower bound, upper bound, and Number
% of subintervals.

if (mod(N, 2) ~= 0)
    N = N + 1;
end

h = (b - a) / N;
x = a : h : b;
f = fun(x);

out = (h / 3) * (f(1) + f(end) + 4 * sum(f(2 : 2 : end - 1)) + 2 * sum(f(3 : 2 : end - 2))); 

end