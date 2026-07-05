function x = BackwardSub(A, b)
[r, c] = size(A);
b = b(:);

if r ~= c 
    error("Matrix is not square!");
end
if r ~= length(b)
    error('Size mismatch!');
end

x = zeros(r, 1);

x(end) = b(end) / A(r, c);

for i = r - 1 : -1 : 1
    x(i) = b(i) - A(i, i + 1 : end) * x(i+1 : end);
    x(i) = x(i) / A(i, i);
end
end
