clear; clc; close all;

%% Bifurcation diagram for logistic growth with constant harvesting
%
% Model:
%
%   dP/dt = r*P*(1 - P/K) - H
%
% Equilibria:
%
%   P_plus(H)  = K/2 * (1 + sqrt(1 - 4H/(K*r)))
%   P_minus(H) = K/2 * (1 - sqrt(1 - 4H/(K*r)))
%
% P_plus  : stable equilibrium branch
% P_minus : unstable equilibrium branch
%
% Critical harvesting:
%
%   H_crit = K*r/4

%% Parameters
r = 0.4;
K = 1000;

%% Critical harvesting rate
Hcrit = K*r/4;

fprintf('Critical harvesting rate = %.2f fish/year\n', Hcrit);

%% Harvesting parameter values
%
% Real equilibria exist only for:
%
%   0 <= H <= Hcrit

H = linspace(0, Hcrit, 500);

%% Equilibrium branches
P_minus = (K/2) .* ...
    (1 - sqrt(1 - 4*H/(K*r)));

P_plus = (K/2) .* ...
    (1 + sqrt(1 - 4*H/(K*r)));

%% Plot bifurcation diagram
figure;

% Stable branch
plot(H, P_plus, '-', ...
    'LineWidth', 2, ...
    'DisplayName', 'Stable equilibrium P_+');

hold on;

% Unstable branch
plot(H, P_minus, '--', ...
    'LineWidth', 2, ...
    'DisplayName', 'Unstable equilibrium P_-');

%% Mark the bifurcation point
plot(Hcrit, K/2, 'o', ...
    'MarkerSize', 8, ...
    'LineWidth', 2, ...
    'DisplayName', 'Saddle-node bifurcation');

%% Mark our original case H = 80
H0 = 80;

P_minus_80 = (K/2) * ...
    (1 - sqrt(1 - 4*H0/(K*r)));

P_plus_80 = (K/2) * ...
    (1 + sqrt(1 - 4*H0/(K*r)));

plot(H0, P_minus_80, 'o', ...
    'MarkerSize', 7, ...
    'HandleVisibility', 'off');

plot(H0, P_plus_80, 'o', ...
    'MarkerSize', 7, ...
    'HandleVisibility', 'off');

%% Labels
xlabel('Harvesting rate H (fish/year)');
ylabel('Equilibrium population P^*');

title('Saddle-Node Bifurcation in Logistic Harvesting Model');

legend('Location', 'best');
grid on;

%% Axis limits
xlim([0 120]);
ylim([0 1050]);

%% Show critical line
xline(Hcrit, ':', ...
    'H_{crit} = 100', ...
    'LabelVerticalAlignment', 'bottom');

% New section starts here 
%% Compare population dynamics below, at, and above bifurcation
%
% We now solve the original population model
%
%   dP/dt = r*P*(1 - P/K) - H
%
% for three harvesting rates:
%
%   H = 80   : below the critical harvesting rate
%   H = 100  : exactly at the bifurcation point
%   H = 120  : above the critical harvesting rate
%
% We use the same initial population P(0) = 700 fish
% in all three cases.

P0 = 700;
tspan = [0 50];

H_below = 80;
H_critical = Hcrit;
H_above = 120;

%% Define the three ODEs
f_below = @(t,P) r*P.*(1 - P/K) - H_below;

f_critical = @(t,P) r*P.*(1 - P/K) - H_critical;

f_above = @(t,P) r*P.*(1 - P/K) - H_above;

%% Solve using ode45
[t1, P1] = ode45(f_below, tspan, P0);

[t2, P2] = ode45(f_critical, tspan, P0);

[t3, P3] = ode45(f_above, tspan, P0);

%% Plot all three solutions in a new figure
figure;

plot(t1, P1, ...
    'LineWidth', 2, ...
    'DisplayName', 'H = 80');

hold on;

plot(t2, P2, ...
    'LineWidth', 2, ...
    'DisplayName', 'H = 100');

plot(t3, P3, ...
    'LineWidth', 2, ...
    'DisplayName', 'H = 120');

%% Show important equilibrium levels
yline(P_plus_80, '--', ...
    'P_+ \approx 723.6', ...
    'HandleVisibility', 'off');

yline(K/2, ':', ...
    'P^* = 500', ...
    'HandleVisibility', 'off');

%% Labels and formatting
xlabel('Time (years)');
ylabel('Population P(t)');

title('Population Dynamics Across the Saddle-Node Bifurcation');

legend('Location', 'best');
grid on;

ylim([0 800]);


% We will add some new section here.
% We will make gui where user will put P_0 and H and 
% then we will show the evolution 

%% Interactive population evolution
%
% The user enters:
%
%   H  = harvesting rate (fish/year)
%   P0 = initial population
%
% Pressing the "Plot / Update" button solves
%
%   dP/dt = r*P*(1 - P/K) - H
%
% using ode45 and plots the population evolution.
%
% The same figure can be reused with different values of H and P0.

%% Create GUI figure
fig_gui = uifigure( ...
    'Name', 'Logistic Harvesting Explorer', ...
    'Position', [200 200 850 550]);

%% Create plotting axes
ax = uiaxes(fig_gui, ...
    'Position', [70 120 720 380]);

xlabel(ax, 'Time (years)');
ylabel(ax, 'Population P(t)');
title(ax, 'Population Evolution');

grid(ax, 'on');

%% Input box for harvesting rate H
uilabel(fig_gui, ...
    'Position', [90 65 130 25], ...
    'Text', 'Harvesting rate H:');

H_input = uieditfield(fig_gui, 'text', ...
    'Position', [220 65 100 25], ...
    'Placeholder', 'e.g. 80');

%% Input box for initial population P0
uilabel(fig_gui, ...
    'Position', [350 65 130 25], ...
    'Text', 'Initial population P_0:');

P0_input = uieditfield(fig_gui, 'text', ...
    'Position', [485 65 100 25], ...
    'Placeholder', 'e.g. 700');

%% Plot / Update button
uibutton(fig_gui, 'push', ...
    'Text', 'Plot / Update', ...
    'Position', [620 62 120 32], ...
    'ButtonPushedFcn', ...
    @(src,event) updatePopulationPlot( ...
    ax, H_input, P0_input, r, K));


% User defined function goes here ::
%% Local functions

function updatePopulationPlot(ax, H_input, P0_input, r, K)

    %% Read user input
    H  = str2double(H_input.Value);
    P0 = str2double(P0_input.Value);

    %% Check user input
    if isnan(H) || isnan(P0)
        uialert(ancestor(ax, 'figure'), ...
            'Please enter numerical values for H and P_0.', ...
            'Invalid Input');
        return;
    end

    if H < 0
        uialert(ancestor(ax, 'figure'), ...
            'Harvesting rate H must be nonnegative.', ...
            'Invalid Input');
        return;
    end

    if P0 < 0
        uialert(ancestor(ax, 'figure'), ...
            'Initial population P_0 must be nonnegative.', ...
            'Invalid Input');
        return;
    end

    %% Critical harvesting rate
    Hcrit = K*r/4;

    %% Define population model
    f = @(t,P) r*P.*(1 - P/K) - H;

    %% Time interval
    tspan = [0 50];

    %% Stop integration if population reaches zero
    options = odeset( ...
        'Events', @extinctionEvent);

    %% Solve the IVP
    [t, P] = ode45(f, tspan, P0, options);

    %% Clear previous graph
    cla(ax);

    %% Plot population evolution
    plot(ax, t, P, ...
        'LineWidth', 2, ...
        'DisplayName', 'P(t)');

    hold(ax, 'on');

    %% Mark initial population
    plot(ax, 0, P0, 'o', ...
        'MarkerSize', 7, ...
        'LineWidth', 1.5, ...
        'DisplayName', 'Initial population');

    %% Plot equilibria when H < Hcrit
    if H < Hcrit

        P_minus = (K/2) * ...
            (1 - sqrt(1 - 4*H/(K*r)));

        P_plus = (K/2) * ...
            (1 + sqrt(1 - 4*H/(K*r)));

        yline(ax, P_minus, '--', ...
            sprintf('P_- = %.1f', P_minus), ...
            'DisplayName', 'Unstable equilibrium');

        yline(ax, P_plus, '--', ...
            sprintf('P_+ = %.1f', P_plus), ...
            'DisplayName', 'Stable equilibrium');

    %% Critical case
    elseif abs(H - Hcrit) < 1e-10

        Pcrit = K/2;

        yline(ax, Pcrit, '--', ...
            sprintf('P^* = %.1f', Pcrit), ...
            'DisplayName', 'Semistable equilibrium');

    end

    %% Labels
    xlabel(ax, 'Time (years)');
    ylabel(ax, 'Population P(t)');

    title(ax, sprintf( ...
        'Population Evolution: H = %.2f,  P_0 = %.2f', ...
        H, P0));

    grid(ax, 'on');
    legend(ax, 'Location', 'best');

    %% Keep population axis physically meaningful
    ylim(ax, [0, max(K, 1.1*P0)]);

    hold(ax, 'off');

end


function [value, isterminal, direction] = extinctionEvent(~, P)

    % Event occurs when population reaches zero
    value = P;

    % Stop ode45 when the event occurs
    isterminal = 1;

    % Detect population crossing zero while decreasing
    direction = -1;

end
