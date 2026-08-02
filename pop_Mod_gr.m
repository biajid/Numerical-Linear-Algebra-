t = [0 25];
ni = [500 3000];
[t, population] = ode45(@popRate, t, ni);

plot(t, population(:, 1), 'r-', t, population(:, 2), 'b', 'LineWidth', 2);
xlabel('Time in days');
ylabel('Population');
legend('Lions', 'Gazelles');
title('Population Dynamics of Lions and Gazelles');