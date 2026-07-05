function x = Tridiagonal(A, b)
% This function accepts a tridiagonal matrix A, and vector b 
% This function returns solution using Thomas algorithm along
% with backsubstiution.

d = diag(A);
u = diag(A, 1);
l = diag(A, -1);

n = length(b);

for i = 2 : n
    
    d(i) = d(i) - (l(i - 1) / d(i - 1)) * u(i - 1);
    
    b(i) = b(i) - (l(i - 1) / d(i - 1)) * b(i - 1);
end

x = zeros(n, 1);

x(end) = b(end) / d(end);

for i = n - 1: -1: 1
    x(i) = (b(i) - u(i) * x(i + 1)) / d(i);
end

end
