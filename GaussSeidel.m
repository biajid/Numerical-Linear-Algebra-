function x = GaussSeidel(A, b, x0, tol, maxIter)
% This function performs Gauss-Seidel iteration to get the solution 
% of a system of equation. 
% Desired arguments: A, b, x0, tol, maxIter

%Step 1: perform the row swap to have maximum diagonal element 
% as the pivot 
b = b(:);
Ab = [A, b];
[m, n] = size(A);

for i = 1 : m 

    [~, maxIndex] = max(abs(Ab(i : end, i)));
    k = i + maxIndex - 1;

    if k ~= i 
        Ab([i, k], :) = Ab([k, i], :);
    end

end

A = Ab(:, 1 : end - 1);
b = Ab(:, end);

% step 2: design matrix C and column d 
C = -A;
d = zeros(m, 1);

d = b;

for i = 1 : n
    C(i, i) = 0;
    C(i, :) = C(i, :) / A(i, i);
    d(i) = d(i) / A(i, i);
end

x_old = x0(:);
x = zeros(m, 1);

counter = 0;

while counter <= maxIter
    for i = 1 : n 
        x(i) = C(i, :) * x + d(i);
    end
    counter = counter + 1;
    fprintf("Iteration = %d , solution: ", counter);
    disp(x');
    fprintf('\n\n');
    
    if norm(x - x_old) < tol
        disp('Solution has converged.');
        return;
    end
    x_old = x;
end

if counter > maxIter
    disp("Solution didn't converge");
end
end
