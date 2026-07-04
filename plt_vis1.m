clc;
subplot(2, 2,1);
x = linspace(0.1, 60, 1000);
y = 2 .^ (-0.2 * x + 10);
plot(x, y, 'Color', 'red', 'LineWidth', 2);

subplot(2,2,2);
semilogy(x, y);

subplot(2,2,3);
loglog(x, y);

subplot(2, 2,4);
xd = [10 : 2 : 22];
yd = [950 640 460 340 250 180 140];
yderr = [30 20 18 35 20 30 10];
errorbar(xd, yd, yderr);
xlabel('Distance(cm)');
ylabel('Intensity(lux)');
title('Error Visualization');

