clear; clc; close all;

% Define x and y ranges for the surface.
x = -1 : 0.05 : 1;
y = -1 : 0.05 : 1;
[x, y] = meshgrid(x, y);
z = sin(pi * x) .* cos(pi * y);

figure("Color", 'w', 'Position', [100, 100, 1000, 600]);
mesh(x, y, z, "EdgeColor", [0.7 0.7 0.7], 'FaceAlpha', 0.1, 'DisplayName', ... 
'Real Surface z = sin(\pi x)cos(\pi y)');
xlabel('x');
ylabel('y');
hold on; grid on; box on;

% Now define control point and contro grid;
number_control_point = 8;
u_control = linspace(0, 1, number_control_point);
v_control = linspace(0, 1, number_control_point);

[ugrid, vgrid] = meshgrid(u_control, v_control);

% Now map ugrid and vgrid to [-1, 1]
px = -1 + 2 * ugrid;
py = -1 + 2 * vgrid;
pz = sin(pi * px) .* cos(pi * py);

% Now we have to select how many point we would evaluate in our final grid
n = 50;
u_eval = linspace(0, 1, n);
v_eval = linspace(0, 1, n);

% Now here is the trick. We have a 3D space, and we will get 2 parameter. 
% We will take x, y, z from each row of Px, Py, Pz, and evaluate temporary point 
% for all u. 
% So for each row of Px, Py, Pz we will n points with x, y, z coordinate. 
% We will collect them and put them three temporary Matrix, X, Y, Z. 
% so each X, Y, Z would have n rows, and num_control_point columns, as that many 
% layer we have on the control grid.
X = zeros(n, number_control_point);
Y = zeros(n, number_control_point);
Z = zeros(n, number_control_point);

for i = 1 : number_control_point
    P = [px(i, :)', py(i, :)', pz(i, :)'];
    T = Bezier_CastelJau_Curve(P, u_eval);
    X(:, i) = T(:, 1);
    Y(:, i) = T(:, 2);
    Z(:, i) = T(:, 3);
end

% Now we will fix a u, and send the whole corresponding temporary 
% x, y, z that were calculated for that fix u, with all v to 
% Bezier_CastelJau_Curve function. That way for a fix u, we get all vs.
% Then from the return of that function, we will collect one row of xs,
% one row of ys and one row zs.

% Also we need to predefine 3 n * n matrix to save the X, Y, Z final grid.
X_surf = zeros(n, n);
Y_surf = zeros(n, n);
Z_surf = zeros(n, n);



for i = 1 : n 
    % for each u, say for u1, we gotta take the first x, first y, and first z 
    % from all X, Y, Z. So for u1, we gotta take X as X(i, :)', and so on.
    P = [X(i, :)', Y(i, :)', Z(i, :)'];
    T = Bezier_CastelJau_Curve(P, v_eval);

    % Output T is for each fix u, and for corresponding all vs.
    X_surf(i, :) = T(:, 1)';
    Y_surf(i, :) = T(:, 2)';
    Z_surf(i, :) = T(:, 3)';

end

surf(X_surf, Y_surf, Z_surf, 'FaceAlpha', 0.8, 'EdgeColor', 'k', ...
        'LineWidth', 0.3, 'DisplayName', 'DeCastelJau Surface Patch');
hold off;

figure(3);
surf(X_surf, Y_surf, Z_surf, 'FaceAlpha', 0.8, 'EdgeColor', 'k', ...
        'LineWidth', 0.3, 'DisplayName', 'DeCastelJau Surface Patch');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');

