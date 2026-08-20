function [x, iter, residual, epsilon] = Iterative_refinement ...
    (A, b, epsilon, tol, maxiter)

[m, n] = size(A);

if m ~= n
    error('Matrix must be square!');
end

b = b(:);

if length(b) ~= n
    error('Size mismatch between A and b!');
end

if epsilon <= 0
    error('Epsilon must be a positive number!');
end

if norm(A - A', 'fro') > 1e-12
    error('Matrix A must be symmetric!');
end

% IMPORTANT: preserve sparsity
B = A + epsilon * speye(n);

[L, p] = chol(B, 'lower');

while p ~= 0
    epsilon = 2 * epsilon;
    B = A + epsilon * speye(n);
    [L, p] = chol(B, 'lower');
end

% Initial approximation
y = L \ b;
x = L' \ y;

% Initial residual
r = b - A * x;

iter = 0;

for k = 1:maxiter

    if norm(r, 2) < tol
        break;
    end

    % Correction
    y = L \ r;
    d = L' \ y;

    % Update
    x = x + d;
    r = b - A * x;

    iter = k;
end

residual = norm(r, 2);

end