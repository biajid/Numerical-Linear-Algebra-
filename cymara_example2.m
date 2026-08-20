% This function plots the graph of the function 
% k(x) = {4 ./ (x - 2) on x <= 1, x .^ 2 on x > 1};

x1 = -3 : 0.01  : 0.9999;
x2 = 1 : 0.01 : 2.5;
y1 = @(x) 4 ./ (x - 2);
y2 = @(x) x .^ 2;

plot(x1, y1(x1), 'r', 'LineWidth', 2);
hold on;
plot(x2, y2(x2), 'k', 'LineWidth', 2);
xlabel('X');
ylabel('Y');
title('Graph of a piecewise function');