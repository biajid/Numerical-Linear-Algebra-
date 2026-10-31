function [x, residuals] = naive_krylov_solve(A, b, max_m)
    
    if nargin < 3
        max_m = 40;
    end
    n = length(b);
    u = b; % Use right-hand side b as the starting vector
    K = zeros(n, max_m);
    residuals = zeros(max_m, 1);
    previous = u;
    curr_vector = u;
    
    for m = 1:max_m
        % 1. Store the current power vector into the Krylov matrix K_m
        K(:, m) = curr_vector;
        
        % 2. Form the projected system M = A * K_m
        M = A * K(:, 1:m);
        
        
        % 3. Solve the least-squares problem: min || b - Mz || using backslash
        warning('off');
        z = M \ b;
        warning('on');
        % 4. Reconstruct approximate solution x = K_m * z
        x = K(:, 1:m) * z;
        
        % 5. Record the residual norm || b - Ax ||
        residuals(m) = norm(b - A * x);
        
        if m > 1 & residuals(m) > residuals(m - 1)
            x = previous;
            residuals = residuals(1 : m);
            break;
        end

        % 6. Generate the next power: A^m * u
        curr_vector = A * curr_vector;
        previous = x;
    end
end