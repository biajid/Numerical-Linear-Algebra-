function A = Symmetric_tridiagonal(A)
% This function takes a symmetric matrix A, and turns into 
% a tridiagonal matrix using the Householder reflection method.

if ~issymmetric(A)
    error('Given matrix A is not symmetric!');
end

[~, n] = size(A);

for j = 1 : n - 2
    x = A(j : end, j);
    e = zeros(n, 1);
    

    e(1 : j) = A(1 : j, j);
    e(j + 1) = norm(x(2 : end));
    
    v = A(:, j) - e;
    v = v / norm(v);
    
    H = eye(n) - 2 * v * v';

    A = H * A * H;

  

end

