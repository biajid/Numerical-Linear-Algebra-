function x = Gauss(A, b)
ab = [A, b];
[r, c] = size(A);
if r ~= c
    error('Matrix is not square!');
end

[r, c] = size(ab);

for i = 1 : r - 1
    for j = i + 1 : r
        ab(j, i : end) = ab(j, i : end) - (ab(j, i) / ab(i, i)) * ab(i, i : end);
    end
end

% Now do the back substitution
x = zeros(r, 1);
x(end) = ab(r, c) / ab(r, c - 1);

for i = r - 1 : -1 : 1
    x(i) = ab(i, end) - ab(i, i + 1 : end - 1) * x(i + 1 : end);
    x(i) = x(i) / ab(i, i);
end
end



