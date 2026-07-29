function [t, y] = heun_method(f, a, b, h, y0)
    % This function implements Heun's method (also known as the improved Euler method) for solving  
    % first-order ordinary differential equations (ODEs) of the form dy/dt = f(t, y) with initial condition y(a) = y0.
    % Inputs:
    %   f   - function handle representing the ODE dy/dt = f(t, y)
    %   a   - initial time
    %   b   - final time
    %   h   - step size
    %   y0  - initial value y(a)
    % Outputs:
    %   t   - vector of time points
    %   y   - vector of solution values corresponding to time points in t
    % Example usage:
    %   [t, y] = heun_method(@(t, y) -0.8 * y^(3/2) + 10 * 2000 * (1 - exp(-3*t)), 0, 0.5, 0.002, 2000);

    n = floor((b - a) / h);
    h = (b - a) / n;

    t = zeros(1, n + 1);
    y = zeros(1, n + 1);

    t(1) = a;
    y(1) = y0;

    for i = 1 : n
        t(i + 1) = t(i) + h;
        k1 = f(t(i), y(i));
        k2 = f(t(i) + (2 / 3) * h, y(i) + (2 / 3) * k1 * h);
        y(i + 1) = y(i) + (k1 + 3 * k2) * (h / 4);
    end

end
