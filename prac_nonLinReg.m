x1 = [1 2 3]';
x2 = [2 1.5 3]';
y = [0.5; 0.8; 1.2];

theta = [1; 1];
max_iteration = 100;
tolerance = 1e-6;

fprintf('%s\n', repmat('-',1,60));
fprintf("Iteration\t\t theta_1\t theta2\t Residue SS\n");
fprintf('%s\n', repmat('-',1,60));

J = zeros(length(y), 2);
t1 = 1.0;
t2 = 1.0;

for iteration = 1 : max_iteration
    

    f = (t1 .* x1 .* x2) ./ (t2 + x1);
    b = y - f;
    ss_residual = sum(b .^ 2);
    
    fprintf("%d\t\t %.4f\t%.4f\t%.6f\n", iteration, t1, t2, ss_residual);

    J(:, 1) = (x1 .* x2) ./ (t2 + x1);
    J(:, 2) = -(t1 .* x1 .* x2) ./ (t2 + x1) .^ 2;
    
    delta = (J' * J) \ (J' * b);
    t1 = t1 + delta(1);
    t2 = t2 + delta(2);

    if norm(delta) < tolerance
        fprintf('\n%s\n', repmat('-',1,60));
        fprintf("Converged successfully with %d iteration\n", iteration);
        break;
    end

end

fprintf("\nFinal result for the parameters: \n");
fprintf("theta_1 = %.4f, and theta_2 = %.4f\n", t1, t2);

