function [lambda, v, iter] = my_power_method(A, tol, max_iter, guess_eig)
    % This function will calculate the smallest eigenvalue of a 
    % matrix through shifted inverse power iteration, and would perform better if the matrix is symmetric.
    % usage [lambda, v, iter] = my_power_method(A, tolerance, max_iter, guess_eig)
    if nargin < 4
        guess_eig = min(sum(abs(A), 2));
    end
    if nargin < 3
        max_iter = 100;
    end

    if nargin < 2
        tol = 1e-6;
    end
    % I need to add the parent directory to the path if necessary
    addpath("..");
    n = size(A, 1);
    v = rand(n, 1);
    v = v / norm(v);

    
    A_tilda = A - guess_eig * eye(n);
    [L, U] = lu(A_tilda);

    lambda_old = v' * A * v;
    for k = 1 : max_iter
        % I will do shifted power iteration on equation A*v_{k + 1} = v_{k}
        y = L \ v;
        v = U \ y;
        v = v / norm(v);
        lambda = v' * A_tilda * v;

        if abs(lambda - lambda_old) < tol
            break;
        end
        lambda_old = lambda;
    end

    iter = k;

    lambda = v' * A_tilda * v;
    lambda = lambda + guess_eig;
    
end
