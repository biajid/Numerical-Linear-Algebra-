% =========================================================================
% Steepest Descent 3D: Polished Interactive Simulation
% Objective: Minimize J(x) = 0.5 * x'*A*x - x'*b (solving Ax = b)
% =========================================================================

clear; clc; close all;

% 1. Define the system matrix A (Symmetric & Positive Definite) and vector b
A = [3, 1; 
     1, 2];
b = [1; 
     2];

% Calculate the exact theoretical solution (the bottom of the bowl)
x_exact = A \ b;
J_exact = 0.5 * x_exact' * A * x_exact - x_exact' * b;

% 2. Set up a grid to plot the 3D surface of the functional J(x)
x1_range = linspace(-2.5, 4.5, 150);
x2_range = linspace(-2.5, 4.5, 150);
[X1, X2] = meshgrid(x1_range, x2_range);
J = zeros(size(X1));
for i = 1:size(X1, 1)
    for j = 1:size(X1, 2)
        x_vec = [X1(i,j); X2(i,j)];
        J(i,j) = 0.5 * x_vec' * A * x_vec - x_vec' * b;
    end
end

% 3. Set up the 3D Figure and Surface Bowl with a Nicely Framed Initial View
figure('Color', 'white', 'Position', [100, 100, 1000, 800]);

% Plot the smooth 3D surface bowl
surf(X1, X2, J, 'EdgeColor', 'none', 'FaceAlpha', 0.55);
colormap(jet);
colorbar;
hold on;
shading interp;
lighting gouraud;
camlight('headlight');
material shiny;

% Plot the exact minimum at the absolute bottom of the bowl
plot3(x_exact(1), x_exact(2), J_exact, 'bp', 'MarkerSize', 14, ...
    'MarkerFaceColor', 'b', 'DisplayName', 'Exact Minimum (x^*)');

% Graph formatting and optimized initial view angle
title({'Steepest Descent 3D: Interactive Steepest Descent', ...
       '*** Look at the Figure Window: Click anywhere on the bowl to set starting point! ***'}, ...
       'FontSize', 11, 'FontWeight', 'bold');
xlabel('x_1', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('x_2', 'FontSize', 10, 'FontWeight', 'bold');
zlabel('J(x)', 'FontSize', 10, 'FontWeight', 'bold');
grid on;

% Polished initial camera framing and perspective
view(-45, 30); 
axis tight;
axis vis3d;

% 4. Interactive Starting Point via ginput
fprintf('-----------------------------------------------------\n');
fprintf(' Waiting for input: Click anywhere on the 3D bowl...\n');
fprintf('-----------------------------------------------------\n');

[click_x1, click_x2] = ginput(1);

x_current = [click_x1; click_x2];
J_current = 0.5 * x_current' * A * x_current - x_current' * b;

fprintf(' Starting point selected: x1 = %.2f, x2 = %.2f\n', x_current(1), x_current(2));
fprintf(' Go to your Command Window and press [Enter] to take each step!\n\n');

% Draw the initial contour ellipse at the starting point
contour3(X1, X2, J, [J_current, J_current], 'LineWidth', 1.5, 'Color', [0.1 0.1 0.1]);

% Create handles for the live straight-line path and current position marker
h_path = plot3(x_current(1), x_current(2), J_current, 'r-', 'LineWidth', 2.5, ...
    'DisplayName', 'Straight-Line Path');
h_current = plot3(x_current(1), x_current(2), J_current, 'ko', 'MarkerSize', 11, ...
    'MarkerFaceColor', 'y', 'DisplayName', 'Current Position');

legend('Location', 'northeast');

max_iter = 15;
tolerance = 1e-6;

% 5. Step-by-Step Interactive Loop
for k = 1:max_iter
    % Compute the gradient (Jacobian): grad_J = A*x - b
    grad_J = A * x_current - b;
    
    % Check if we've reached the bottom
    if norm(grad_J) < tolerance
        fprintf('\nConvergence reached! You hit the bottom of the bowl.\n');
        break;
    end
    
    % Search direction is the negative gradient (steepest descent) -> Straight line vector
    v = -grad_J;
    
    % Calculate the exact optimal step size (alpha)
    alpha = (v' * v) / (v' * A * v);
    
    % Target position at the end of this straight-line search
    x_next = x_current + alpha * v;
    
    % Pause execution and wait for user to press Enter in the Command Window
    input(sprintf('Iteration %2d: Press [Enter] to draw straight line...', k));

    % Smooth Animation: Draw the straight line step-by-step
    num_substeps = 30;
    for s = 1:num_substeps
        fraction = s / num_substeps;
        x_sub = x_current + fraction * (alpha * v);
        J_sub = 0.5 * x_sub' * A * x_sub - x_sub' * b;
        
        % Update current position marker
        set(h_current, 'XData', x_sub(1), 'YData', x_sub(2), 'ZData', J_sub);
        
        % Append point to the visible straight-line path
        curr_X = get(h_path, 'XData');
        curr_Y = get(h_path, 'YData');
        curr_Z = get(h_path, 'ZData');
        
        set(h_path, 'XData', [curr_X, x_sub(1)], ...
                  'YData', [curr_Y, x_sub(2)], ...
                  'ZData', [curr_Z, J_sub]);
              
        drawnow;
        pause(0.01);
    end
    
    % Once small steps complete, draw and leave behind the contour ellipse at the new point
    J_next = 0.5 * x_next' * A * x_next - x_next' * b;
    contour3(X1, X2, J, [J_next, J_next], 'LineWidth', 1.5, 'Color', [0.1 0.1 0.1]);
    
    % Move current reference forward
    x_current = x_next;
end

fprintf('\nSimulation complete!\n');
hold off;