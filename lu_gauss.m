function [L, U] = lu_gauss(A)

[r, c] = size(A);
if r ~= c
    error('Matrix is not square!');
end

L = diag(ones(r, 1));
U = zeros(r, c);

for i = 1 : r - 1
    for j = i + 1 : r
        L(j, i) = A(j, i) / A(i, i);
        A(j, i : end) = A(j, i : end) - (A(j, i) / A(i, i)) * A(i, i : end);
    end
end

U = A;
end
