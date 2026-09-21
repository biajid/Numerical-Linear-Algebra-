clear; clc; close all;

%% Logistic growth with constant harvesting
% Model:
%
%   dP/dt = r*P*(1 - P/K) - H
%
% with
%   r = 0.4 per year
%   K = 1000 fish
%   H = 80 fish/year
%   P(0) = 700 fish
%
% We derived analytically that the stable equilibrium is
% approximately P_plus = 723.6 fish.

%% Parameters
r = 0.4;
K = 1000;
H = 80;
P0 = 700;

%% Dimensionless harvesting parameter
h = H / (K*r);

fprintf('Dimensionless harvesting parameter h = %.4f\n', h);

%% Equilibria in dimensionless variables
u_minus = (1 - sqrt(1 - 4*h)) / 2;
u_plus  = (1 + sqrt(1 - 4*h)) / 2;

fprintf('u_minus = %.6f\n', u_minus);
fprintf('u_plus  = %.6f\n', u_plus);

%% Convert equilibria back to fish population
P_minus = K * u_minus;
P_plus  = K * u_plus;

fprintf('P_minus = %.2f fish\n', P_minus);
fprintf('P_plus  = %.2f fish\n', P_plus);

%% Analytical solution
% Dimensionless initial condition
u0 = P0 / K;

% Difference between the two equilibria
d = u_plus - u_minus;

% Constant determined from the initial condition
q0 = (u_plus - u0) / (u0 - u_minus);

% Since tau = r*t, the exponential becomes exp(-d*r*t)
u_exact = @(t) ...
    (u_plus + u_minus*q0.*exp(-d*r*t)) ./ ...
    (1 + q0.*exp(-d*r*t));

% Convert back to physical population
P_exact = @(t) K * u_exact(t);

%% Numerical solution using ode45
odefun = @(t,P) r*P.*(1 - P/K) - H;

tspan = [0 50];

[t_num, P_num] = ode45(odefun, tspan, P0);

%% Evaluate analytical solution at same times
P_exact_num = P_exact(t_num);

%% Plot analytical and numerical solutions
figure;

plot(t_num, P_num, 'o', ...
    'DisplayName', 'ode45 numerical solution');
hold on;

plot(t_num, P_exact_num, '-', ...
    'LineWidth', 2, ...
    'DisplayName', 'Analytical solution');

yline(P_plus, '--', ...
    'DisplayName', 'Stable equilibrium');

xlabel('Time (years)');
ylabel('Population P(t)');
title('Logistic Growth with Constant Harvesting');

legend('Location', 'best');
grid on;

%% Compute numerical error
error = abs(P_num - P_exact_num);

fprintf('Maximum absolute error = %.6e fish\n', max(error));

%% Plot the error
figure;

semilogy(t_num, error, 'LineWidth', 2);

xlabel('Time (years)');
ylabel('|P_{ode45} - P_{exact}|');
title('Error Between ode45 and Analytical Solution');

grid on;