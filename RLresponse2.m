clear all;
V = 6;
R = 2;
L = 0.5;

t = 0  : 1e-6 : 3;
disp("Using Preallocated memory and find command..");

tic
i = zeros(size(t));

i(find(t <= 1)) = V/R * (1 - exp(-R/L * t(find(t<=1))));
i(find(t > 1)) = V/R * (exp(R/L) - 1) * exp(-R/L * t(find(t > 1)));

toc
%{
plot(t, i, LineStyle="-", Color='red', LineWidth=3);
xlabel('Time (s)');
ylabel('Current (A)');
title('Current vs Time');
grid on;

%}