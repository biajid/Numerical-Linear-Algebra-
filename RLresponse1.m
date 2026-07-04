clear all;
V = 6;
R = 2;
L = 0.5;

t = 0  : 1e-6 : 3;
disp("Loops, with no preallocation of the memory");

tic
for k = 1 : length(t)
    if (t(k) <= 1)
        i(k) = V/R * (1 - exp((-R/L) * t(k)));
    else
        i(k) = V/R * (exp(R/L) - 1) * exp((-R/L) * t(k));
    end
end
toc
%{
% Now draw the graph
plot(t, i, LineStyle="-", Color='red', LineWidth=3);
xlabel('Time (s)');
ylabel('Current (A)');
title('Current vs Time');
grid on;
toc

%}
