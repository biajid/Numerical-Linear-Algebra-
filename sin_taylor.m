clear all;
close all;

x = -10 : 0.01 : 10;
y = sin(x);
plot(x, y, 'k', 'LineWidth', 2);
axis([-10 10 -10 10]);
grid on; hold on;

%Taylor expansion first order
p = [1 0];
yt1 = polyval(p, x);
plot(x, yt1, 'b--', 'LineWidth', 1.5);

