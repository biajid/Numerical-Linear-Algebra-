% In this problem we are tryig to solve the boundary value problem : 
% y'' = y, y(0) = 1, y(1) = 0.
% Let y1 = y; y2 = y'; So we have: 
% y1' = y2 and y2' = y'' = y = y1.
% So the system of first order ODEs is:
% y1' = y2  
% y2' = y1
% with boundary conditions:
% y1(0) = y(0) = 1
% y2(0) = y1'(0) = alpha we assumed for now.
% Now we need an auxiliary function eta = dy/d(alpha);
% let eta1 = eta; eta2 = eta'; 
% now eta(0) = dy/d(alpha) at x(0) = 0, because y(0) does not depend on alpha, so eta1(0) = 0, eta2(0) = 1.
% eta' = d/d(alpha) (y') = d/d(alpha) y1' = d/d(alpha) y2 
% eta'(0) = d/d(alpha) y2(0) = d/d(alpha) alpha = 1.

a = 0; b = 1;
y_a = 1; y_b = 0;
tolerance = 1e-6;
max_iter = 20;

alpha = 1.0;

fprintf("Iter\t Alpha(Guess)\t y(b)\t Error\n");

for iter = 1 : max_iter
    y0 = [y_a; alpha; 0; 1];
    [x, y] = ode45(@auxiliary1, [a, b], y0);
    y_final = y(end, 1);
    eta_final = y(end, 3);

    err = abs(y_final - y_b);

    if abs(err) < tolerance
        fprintf('\n Converged to optimal slopes alpha = %0.6f\t in %d iterations.', alpha, iter);
        break;
    end

    alpha = alpha - (y_final - y_b) / eta_final;
end

figure(1);
plot(x, y(:, 1), 'b-o', 'LineWidth', 1.5, 'MarkerSize', 4);
hold on;
plot([a, b], [y_a, y_b], 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red');
grid on;
xlabel('X');
ylabel('Y = f(x)');
title('Shooting Method via Newton Raphson Method');
legend('Numerical Solution', 'Boundary Conditions');







