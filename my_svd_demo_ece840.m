M = 10;
N = 7;
A = round(100 * rand(M,N) - 50);
[U, S, V] = svd(A);
S = diag(S);
Atilde = 0;

for k = 1 : min(M, N)
    Atilde = Atilde + S(k) * U(:, k) * V(:, k)';
    fprintf("Rank of Atilde : %3d\n ||A - Atilde|| = %10.6f\n", ... 
        rank(Atilde), norm(A - Atilde));
    pause;
end


