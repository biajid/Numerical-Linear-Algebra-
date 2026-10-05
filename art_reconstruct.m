function x = art_reconstruct(A, b, x0, num_cycles, tol)
    % This function solves Ax = b using the 
    % algebraic reconstruction technique. 
    % Inputs: 
    % A : A matrix of size m X n;
    % b : Measurement vector of size (M X 1);
    % x0 : Initial guess vector of size (N X 1); (must needed)
    % num_cylces : number of max_iteration
    % tol : tolerance

    % Output : x -> The solution vector of size M X 1;

   
    if nargin < 4
        num_cycles = 100;
    end

    if nargin < 5
        tol = 1e-6;
    end

    b = b(:);
    if size(A, 1) ~= numel(b) || numel(x0) ~= size(A, 2)
        error('Dimensions of A, b, and x0 are inconsistent.');
    end
    

    [m, ~] = size(A);
    row_norms = sum(A .^ 2, 2);

    x = x0(:);

    

    for c = 1 : num_cycles
        xold = x;
        for k = 1 : m 
            % extracting the kth row
            a_k = A(k, :);
            residual = b(k) - a_k * x;
            if row_norms(k) == 0, continue; end
            % update the x
            x = x + (residual / row_norms(k)) * a_k(:);
        end
        
        if norm(xold) > 0 && (norm(x - xold) / norm(xold) <= tol)
            disp(c);
            return;
        end
    end
end
