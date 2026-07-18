function dv = derivative(x, y)
% This function takes x and y as data values, x : domain, y : range.
% This function generates at all points.
% For 1st point : use Forward difference formula 
% For last point : use Backward difference formula
% All internal points : use central difference formula
x = x(:)'; y = y(:)';
n = length(x);
if n ~= length(y) 
    error("Length mismatch in x and y");
end

dv = zeros(1, n);

dv(1) = (y(2) - y(1)) / (x(2) - x(1));
dv(end) = (y(end) - y(end - 1)) / (x(end) - x(end - 1));

for i = 2 : n - 1
    dv(i) = (y(i + 1) - y(i - 1)) / (x(i + 1) - x(i - 1));
end

end
