f = @(x) x .^ 2 - 2;
fdiff = @(x) 2 .* x;

t = 0.1 : 0.01 : 10;
y = f(t);

x0 = 9.8;

iteration = 1000;
xnext = x0;
guess = [x0];

fprintf("Initial guess = %.12f\n", xnext);

figure;
plot(t, y, 'k--', 'LineWidth', 2);
hold on;
grid on;
yline(0, 'b-');   % x-axis

colors = {'r','g','b','c','m','y','k'};
for i = 1 : iteration
    %cmap = parula(iteration);
    color = colors{randi(length(colors))};
    fx = f(xnext);
    dfx = fdiff(xnext);

    % Newton update
    xnew = xnext - fx / dfx;

    fprintf("x_%d = %.12f\n", i, xnew);

    % Plot current point on the curve
    %plot(xnext, fx, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    plot(xnext, fx, 'o', 'Color', color, 'MarkerSize', 8, 'LineWidth', 2);

    % Tangent line near xnext
    xtan = linspace(xnext - 5, xnext + 5, 200);
    ytan = fx + dfx .* (xtan - xnext);
    %plot(xtan, ytan, 'g-', 'LineWidth', 1.5);
    plot(xtan, ytan, 'Color', color, 'LineWidth', 2);

    % Plot where tangent hits x-axis = next Newton iterate
    plot(xnew, 0, 'Color', color, 'MarkerSize', 8, 'LineWidth', 2);

    % Optional: vertical line from xnew on x-axis up to the curve
    plot([xnew xnew], [0 f(xnew)], 'm--', 'LineWidth', 1.2);

    pause(0.5);

    guess = [guess, xnew];

    if abs(f(xnew)) < 1e-10
        xnext = xnew;
        break;
    end

    xnext = xnew;
end

% Plot all iterates on the curve at the end
plot(guess, f(guess), 'ks', 'MarkerSize', 6, 'LineWidth', 1.5);

xlabel('x');
ylabel('f(x)');
title('Newton Method with Tangent Lines');
hold off;

fprintf("With %d iterations of Newton's method\n", i);
fprintf("root = %.12f\n", xnext);
fprintf("Error = %.12e\n", abs(sqrt(2) - xnext));