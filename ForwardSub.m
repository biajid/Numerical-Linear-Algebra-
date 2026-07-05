function x = ForwardSub(A, b)
[r, c] = size(A);
b = b(:);

if r ~= c
    error('Matrix is not square!');
end

if length(b) ~= c
    error('Length mismatch');
end

x = zeros(r, 1);

x(1) = b(1) / A(1, 1);
for i = 2 : r
    x(i) = b(i) - A(i, 1 : i - 1) * x(1 : i - 1);
    x(i) = x(i) / A(i, i);
end
end


