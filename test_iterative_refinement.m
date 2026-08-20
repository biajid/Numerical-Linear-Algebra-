clear; clc;

n = 1000000;

% Construct a sparse 1D Poisson matrix
e = ones(n, 1);

A = spdiags([-e, 2*e, -e], -1:1, n, n);

% Known exact solution
x_exact = ones(n, 1);

% Construct the right-hand side
b = A * x_exact;

% Parameters
epsilon = 1e-3;
tol = 1e-10;
maxiter = 1000;

% Solve using your iterative refinement function
[x, iter, residual, epsilon_used] = ...
    Iterative_refinement(A, b, epsilon, tol, maxiter);

% Results
fprintf('Matrix size       = %d x %d\n', n, n);
fprintf('Iterations        = %d\n', iter);
fprintf('Final residual    = %.4e\n', residual);
fprintf('Epsilon used      = %.4e\n', epsilon_used);
fprintf('Solution error    = %.4e\n', norm(x - x_exact, 2));