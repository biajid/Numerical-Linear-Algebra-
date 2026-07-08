function [Q, R] = QRFactorization_Householer(A)
% This function performs QR Factorization on a given matrix A, 
% utilizing Householder reflection procedure.
[m, n] = size(A);
R = A;
Q = eye(m);

for j = 1 : m - 1
    x = R(:, j);
    x(1 : j - 1) = 0;
    a = norm(x);
    e = zeros(m, 1);
    
    e(j) = -a;
    
    v = x - e;

    v = v / norm(v);

    H = eye(m) - 2 * v * v';

    R = H * R;
    Q = Q * H;
end

end