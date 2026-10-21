function [C, Q] = lagrange_Reduction(A)
    % This function performs a congruent reduction
    % of a symmetric matrix A.
    % [C, Q] = A;
    % Q * A * Q' = C;

    [m, n] = size(A);

    if n ~= m
        error('Matrix A must be square!');
    end
    
    A = double(A);
    tol = 1e-12;
    Q = eye(n);
    C = A;
    if norm(A - A', 'fro') > tol
        error('Matrix A has to be symmetric');
    end
    
    for i = 1 : n 
        if abs(C(i, i)) <= tol
            % Look for non-zero pivot diagonally
            j = find(abs(diag(C(i + 1 : n, i + 1 : n))), 1);
            if ~isempty(j)
                j = j + i;
                % Now interchange the row in C and Q
                C([i, j], :) = C([j, i], :);
                C(:, [i, j]) = C(:, [j, i]);
                Q([i, j], :) = Q([i, j], :);
            else

                % Now search for non zero entry off diagonally
                j = find(abs(C(i, i + 1 : end)) > tol, 1);
                if isempty(j)
                    continue;
                end
                j = j + i;
                C(i, :) = C(i, :) + C(j, :);
                C(:, i) = C(:, i) + C(:, j);
                Q(i, :) = Q(i, :) + Q(j, :);
            end

        end

        % Now perform the elimination operation
        if abs(C(i, i)) > tol
            for k = i + 1 : n
                factor = C(k, i) / C(i, i);
                C(k, :) = C(k, :) - factor * C(i, :);
                C(:, k) = C(:, k) - factor * C(:, i);
                Q(k, :) = Q(k, :) - factor * Q(i, :);
            end
        end

         

    end

    C = diag(diag(C));
    end
