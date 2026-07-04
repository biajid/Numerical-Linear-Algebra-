clear all; close all; clc;

clf;
x = [10 : 0.1 : 22];
y = 95000 ./ x .^ 2;
xd = [10 : 2 : 22];
yd = [950 640 460 340 250 180 140];
plot(x, y, '-', 'LineWidth', 2, 'Color', 'red');
xlabel('Distance(cm)');
ylabel('Intensity(lux)');
title('Light Intensity');
axis([8 24 0 1200]);
[a, b] = ginput(1);
text(a, b, 'Comparison between theory and experiment', 'EdgeColor', 'black', 'Color', 'r');
hold on;
plot(xd, yd, 'o--', 'Color', 'blue', 'LineWidth', 2, 'markersize', 3);
legend('Theory', 'Experiment');
hold off;


