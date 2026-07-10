function [a1, a0] = LinearRegression(X, Y)
% This function computes the coefficient a1, and a0 to 
% to fit the data on y = a1 * x + a0 model.

if length(X) ~= length(Y)
    error('Size mismatch!');
end

Sx = sum(X);
Sy = sum(Y);
Sxy = sum(X .* Y);
Sxx = sum(X .* X);
n = length(X);

a1 = (n * Sxy - Sx * Sy) / (n * Sxx - Sx^2);
a0 = (Sxx * Sy - Sxy * Sx) / (n * Sxx - Sx^2);
end















