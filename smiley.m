t = linspace(0, 2 * pi, 500);
x = cos(t);
y = sin(t);
plot(x, y, 'k', 'LineWidth', 2);
axis equal;
hold on;

x1 = 0.1 * x + 0.35;
y1 = 0.1 * y + 0.2;
plot(x1, y1, 'k', 'LineWidth', 1.5);

x2 = 0.1 * x - 0.35;
y2 = 0.1 * y + 0.2;
plot(x2, y2, 'k', 'LineWidth', 1.5);

% Now we need the curved arc
t = 7 * pi / 6 : 0.05 : 11 * pi / 6;
x = 0.5 * cos(t);
y = 0.5 * sin(t);
plot(x, y, 'k', 'LineWidth', 1.5);
axis off;
hold off;
