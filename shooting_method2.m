clear; clc; close all;

maxiter = 20;
a = 1; b = 2; y_a = 1; y_prime_a = -.5;
y_b = 0.5;

fprintf('Iter: \t\t alpha \t\t error \n');

for iter = 1 : maxiter
    alpha = y_prime_a;
    [x, y] = ode45(@auxiliary, [a, b], [y_a; alpha; 0; 1]);

    err = abs(y(end, 1) - y_b);

    fprintf('%d\t %12.6f\t %12.6e\n', iter, alpha, err);

    if err < 1e-6
        fprintf("System has converged after %d iteration.\n", iter);
        break;
    end

    y_prime_a = alpha - (y(end, 1) - y_b) / y(end, 3);
end


figure(2);
plot(x, y(:, 1), 'color', 'red', 'LineWidth', 2);
hold on;
plot([a, b], [y_a, y_b], 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
grid on;
xlabel('X');
ylabel('Y(x)');
title('Shooting Method via Newton Raphson Method.');
legend('Numerical Solution', 'Boundary Condition', 'Location', 'best');










function dydx = auxiliary(~, y)
    y1 = y(1);
    y2 = y(2);
    eta1 = y(3);
    eta2 = y(4);

    dy1_dx = y2;
    dy2_dx = 2 .* y1 .^ 3;
    d_eta1 = eta2;
    d_eta2 = 6 .* y1 .^ 2 .* eta1;

    dydx = [dy1_dx; dy2_dx; d_eta1; d_eta2];

end

