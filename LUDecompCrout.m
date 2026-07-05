function [L, U] = LUDecompCrout(A)

[r, c] = size(A);
if r ~= c 
    error('Matrix is not square!');
end

L = zeros(r, c);
U = eye(r);

% First fill up the first column of L;
for i = 1 : r 
    L(i, 1) = A(i, 1);
end

% Now fill up the first row of U
for i = 2 : c 
    U(1, i) = A(1, i) / L(1, 1);
end

% Now we will fill up the remaining items on L and U.
% The algorithm will go row by row
% First it will get the L's from i >= j, and then it 
% will get the U's from i < j.

for i = 2 : r
    for j = 2 : i 
        L(i, j) = A(i, j) - L(i, 1 : j - 1) * U(1 : j - 1, j);
    end
    for j = i + 1 : c 
        U(i, j) = (A(i, j) - L(i, 1 : i - 1) * U(1 : i - 1, j)) / L(i, i);
    end
end
end

        


