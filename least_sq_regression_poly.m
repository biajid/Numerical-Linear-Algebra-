function C = least_sq_regression_poly(x, y, n)
% This program takes x vector as input data 
% y vector as output data, and n is the degree of the polynomial 
% to be fitted in the data points. 
% This function returns the coefficient of the resulting 
% best fit polynomial f(x) = C(1)  + C(2) * x + ... + C(n) * x^n + C(n + 1) * x^{n + 1}; 
nx = length(x);

if length(x) ~= length(y)
    error('Size Mismatch');
end

A = zeros(nx, n + 1);
A(:, 1) = 1;
x = x(:);
for index = 1 : n 
    A(:, index + 1) = x .^ index;
end

b = y(:);

C = (A' * A) \ (A' * b);

C = C(:)';
end


