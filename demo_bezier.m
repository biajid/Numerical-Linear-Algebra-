close all; clc;

P = [0, 0; 2, 4; 6, 4; 8, 0]; % This are the control points.
t = linspace(0, 1, 100); % this are sample

[curve_pts, B] = Bezier_Curve_eval(P, t);

subplot(1, 2, 1);

plot(P(:, 1), P(:, 2), 'k--o', 'LineWidth', 1.5, 'MarkerFaceColor', 'y', 'MarkerSize', 8, ...
    'DisplayName', 'Control Polygon and Points');
hold on;
plot(curve_pts(1, :), curve_pts(2, :), 'r-', 'LineWidth', 2, 'DisplayName', 'Bezier Curve');
legend('Location', 'best');
xlabel('X-axis');
ylabel('Y-axis');
title('Bezier Curve Evaluation');

% We will now take a given surface as y = sin(x) on [0, pi], 
% and will take say 100 points with t, and will draw the Bezier curve along with the surface.
t = linspace(0, 1, 20); % this are sample points for the surface.
y = sin(t * pi); % This is the surface we are taking.
P_surface = [t; y]'; % This is the control points for the surface.

% Now we will send this points, and dimension to the Bezier_Curve_eval function to get the Bezier curve points.
[curve_pts_surface, B_surface] = Bezier_Curve_eval(P_surface, t);
% Now we will plot the surface and the Bezier curve along with the control points.
subplot(1, 2, 2);
plot(P_surface(:, 1) * pi, P_surface(:, 2), 'k--o', 'LineWidth', 1.5, 'MarkerFaceColor', 'y', 'MarkerSize', ...
    8, 'DisplayName', 'Control Polygon and Points');
hold on;
plot(curve_pts_surface(1, :) * pi, curve_pts_surface(2, :), 'r-', 'LineWidth', 2, 'DisplayName', 'Bezier Curve');
plot(linspace(0, pi, 100), sin(linspace(0, 1, 100) * pi), 'b-', 'LineWidth', 2, 'DisplayName', 'Curve y = sin(x)');
legend('Location', 'best');
xlabel('X-axis');
ylabel('Y-axis');
title('Bezier Curve Evaluation for Surface y = sin(x)');    



