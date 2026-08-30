% In this problem we will explore the 
% graph of the function:
% f(t) = 4 * exp(-2 * t) * cos(6 * t - 60)

% We will first draw two envelope 4 * exp(-2 * t), 
% and -4 * exp(-2 * t), and then we will plot
% f(t) on the same graph to show that 
% indeed f(t) is enveloped by two exponenetials.

t = linspace(0, 2, 1000);
y1 = 4 * exp(-2 * t);

y = 4 * exp(-2 * t) .* cos(6 * t - pi / 3);
figure('Name','Lathi Example')
plot(t, y1, 'r--', 'linewidth', 2);
hold on;
plot(t, -y1, 'r--', 'linewidth', 2);

plot(t, y, 'k', 'linewidth', 2);
yline(0, 'k', 'linewidth', 2);
xlabel('Time t');
ylabel('Signal');
title('Envelope exploration');
hold off;