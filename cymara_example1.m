% Plot the graph of the function y = x .^ 2, 
% along with tangent at the point (1, 1);
% The equation of the tangent y' = 2 * x - 1;
x = -3 : 0.01 : 3;
y = x .^ 2;
plot(x, y, 'LineWidth', 2, 'Color', 'red');
hold on;
ytan = 2 * x - 1;
plot(x, ytan, 'LineWidth', 2, 'Color', 'black');
xlabel('X');
ylabel('Y');
title('Graph of y = x^2 and its tangent on (1, 1)');
hold off;