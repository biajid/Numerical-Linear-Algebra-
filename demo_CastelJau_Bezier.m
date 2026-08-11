close all; clc;

P = [0, 0; 2, 4; 6, 4; 8, 0]; % This are the control points.
t = linspace(0, 1, 100); % this are sample

curve_pts = Bezier_CastelJau_Curve(P, t);

subplot(1, 2, 1);

plot(P(:, 1), P(:, 2), 'k--o', 'LineWidth', 1.5, 'MarkerFaceColor', 'y', 'MarkerSize', 8, ...
    'DisplayName', 'Control Polygon and Points');
hold on;
plot(curve_pts(:, 1), curve_pts(:, 2), 'r-', 'LineWidth', 2, 'DisplayName', 'Bezier Curve');
legend('Location', 'best');
xlabel('X-axis');
ylabel('Y-axis');
title('Bezier Curve Evaluation');

% We will now take a given surface as y = sin(x) on [0, pi], 
% and will take say 20 points with t, and will draw the Bezier curve along with the surface.
t = linspace(0, 1, 20); % this are sample points for the surface.
y = sin(t * pi); % This is the surface we are taking.
P_surface = [t; y]'; % This is the control points for the surface.

t = linspace(0, 1, 100); % this are sample points for the surface.
% Now we will send this points, and dimension to the Bezier_CastelJau_Curve function to get the Bezier curve points.
curve_pts_surface = Bezier_CastelJau_Curve(P_surface, t);
% Now we will plot the surface and the Bezier curve along with the control points.
subplot(1, 2, 2);
plot(P_surface(:, 1) * pi, P_surface(:, 2), 'k--o', 'LineWidth', 1.5, 'MarkerFaceColor', 'y', 'MarkerSize', ...
    8, 'DisplayName', 'Control Polygon and Points');
hold on;
plot(curve_pts_surface(:, 1) * pi, curve_pts_surface(:, 2), 'r-', 'LineWidth', 2, 'DisplayName', 'Bezier-DeCasteljau Curve');
plot(t * pi, sin(t * pi), 'b-', 'LineWidth', 2, 'DisplayName', 'Curve y = sin(x)');
legend('Location', 'best');
xlabel('X-axis');
ylabel('Y-axis');
title('Bezier-DeCasteljau Curve Evaluation for Surface y = sin(x)');    



