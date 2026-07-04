clear all;
close all;

figure(1)
x = linspace(-3, 3, 100);
y1 = x;
y2 = x .^ 3;
y3 = x .^ 5;

plot(x, y1, 'r');
hold on;
plot(x, y2, 'g');
hold on;
plot(x, y3, 'b');
axis('equal');
xlabel('x values');
ylabel('y = sin(x)');
axis([-3, 3, -3, 3]);
legend('y = x', 'y = x ^ 3', 'y = x ^ 5');
hold off;