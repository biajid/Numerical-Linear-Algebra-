% Set up a test problem
n = 50;
A = randn(n, n);
% Make A well-conditioned or positive-definite-ish for a clean test
A = A' * A + eye(n); 
b = randn(n, 1);

% Run our naive Krylov solver up to m = 40 steps
max_m = 40;
[x_approx, res] = naive_krylov_solve(A, b, 1e-12, max_m);

% Plot the residuals on a log scale
figure;
semilogy(1:max_m, res, '-o', 'LineWidth', 1.5);
xlabel('Krylov Subspace Dimension (m)');
ylabel('Residual Norm ||b - Ax||');
title('Naive Monomial Krylov Convergence & Blowup');
grid on;