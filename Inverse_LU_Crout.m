function invA = Inverse_LU_Crout(A)
% This function returns the inverse of a matrix 
% using LU decomposition algorithm invented by Crout

[m, n] = size(A);

if m ~= n 
    error('Matrix is not square!');
end

I = eye(n);
invA = zeros(m, n);

for i = 1 : n
    invA(:, i) = LUSolve(A, I(:, i));
end

end
