x = 0 : pi / 4 : 2 * pi;
y = sin(x);

plot(x, y, 'o', 'MarkerFaceColor', 'k', 'MarkerSize', 8);

hold on;
xx = linspace(0, 2 * pi, 1000);
yy = interp1(x, y, xx, 'spline');

plot(xx, yy, 'r', 'LineWidth', 2);
plot(xx, sin(xx), 'green', 'LineWidth', 1.5);

legend('Data Points', 'Spline Interpolation', 'Original Sine Function');
xlabel('x');
ylabel('y');
title('Sine Function and Interpolation');
grid on;
hold off;


