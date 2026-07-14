function yint = cubic_spline_natural(x, y, xint)
% This function performs the natural cubic spline on the given 
% data and evaluates the resulted polynomial on 
% the vector xint, and returns the result yint as a vector. 
% natural means s1''(x1) = s_{n - 1} ''(xn) = 0;

n = length(x);

if n ~= length(y)
    error('Input vectors x and y must be of the same length.');
end

if n < 3
    error('At least three data points are required.');
end




x = x(:)';
y = y(:)';
xint = xint(:)';
[x, index] = sort(x);
yint = zeros(1, length(xint));
y = y(index);

if any(diff(x) == 0)
    error('The vector x cannot contain duplicate values.');
end

if any(xint < x(1)) || any(xint > x(end))
    error('Interpolation points must lie within the data range.');
end

d = y(1 : n - 1);

h = x(2 : n) - x(1 : n - 1);
f = y(2 : n) - y(1 : n - 1);

b = zeros(1, n - 1);

% I am considering data ranging from (x1, y1) to (xn, yn)
% So have n data points, and consequently (n - 1) intervals.
% for natural spline b1 = 0    by setting S1''(x1) = 0

% so I need to make a tridiagonal matrix of (n - 2) X (n -2) size.
% for b the equation is 
% 1/3 * h(i) * b(i) + 2/3 * (h(i) + h(i + 1) * b(i + 1) + h(i + 1) / 3 *
% b(i + 2) = f(i + 1) / h(i + 1) - f(i) / h(i)
% for making tridiagonal system I would iterate i = 1 to i = n - 2;
 
diagonal = diag(2/3 * (h(1 : n - 2) + h(2 : n - 1)));
super_diagonal = diag(1/3 .* (h(2 : n - 2)), 1);
sub_diagonal = diag(1/3 .* (h(2 : n - 2)), -1);

A = diagonal + super_diagonal + sub_diagonal;
%A

w = (f(2 : n - 1) ./ h(2 : n - 1)) - (f(1 : n - 2) ./ h(1 : n -2));
%w

dummy = tridiagonal(A, w');
b(2 : end) = dummy(:)';

% Now we have b's 
% We need a's and c's
c = zeros(1, n - 1);
a = zeros(1, n - 1);

c(1 : n - 2) = (1 ./ h(1 : n - 2)) .* (f(1 : n - 2) - (h(1 : n - 2) .^ 2) .* ((b(2 : n - 1) + 2 .* b(1 : n - 2))./3));

a(1 : n - 2) = (1 ./ (3 .* h(1 : n - 2))) .* (b(2 : n -1) - b(1 : n - 2));



a(n - 1) = - b(n - 1) / (3 * h(end));
c(n - 1) = (1 / h(end)) * (f(end) - a(end) * h(end) ^ 3 - b(end) * h(end) ^ 2);

% Now we will evaluate the polynomial on xint.



for i = 1 : length(xint)
    term = xint(i);

    for j = 1 : length(x)
        if term == x(j)
            yint(i) = y(j);
            break;
        end
        if (term < x(j))
            yint(i) = a(j - 1) * (term - x(j - 1)) ^ 3 + ...
                b(j - 1) * (term - x(j - 1)) ^ 2 + ...
                c(j - 1) * (term - x(j - 1)) + d(j - 1);
            break;
        else
            continue;
        end
    end
end

end


       


            





