function [t, y, z] = sys2ODEsRK4(f1, f2, t0, tf, y0, z0, h)
    % This function solves a system of two first-order ordinary differential equations
    % dy/dt = f1(t, y, z) and dz/dt = f2(t, y, z) using the classical   fourth-order Runge-Kutta method (RK4)
    % over the interval [t0, tf] with initial conditions y0 and z0 and step size h.
    % Inputs:
    %   f1 - function handle for dy/dt = f1(t, y, z)
    %   f2 - function handle for dz/dt = f2(t, y, z)
    %   t0 - initial time
    %   tf - final time
    %   y0 - initial value for y
    %   z0 - initial value for z
    %   h  - step size
    %
    % Outputs:
    %   t - vector of time points
    %   y - vector of y values
    %   z - vector of z values
    %
    % Usage: [t, y, z] = sys2ODEsRK4(f1, f2, t0, tf, y0, z0, h);

    n = floor((tf - t0) / h);
    h = (tf - t0) / n;

    t = zeros(1, n + 1);
    y = zeros(1, n + 1);
    z = zeros(1, n + 1);

    t(1) = t0; y(1) = y0; z(1) = z0;

    for i = 1 : n
        t(i + 1) = t(i) + h;
        k1y = f1(t(i), y(i), z(i));
        k1z = f2(t(i), y(i), z(i));
        k2y = f1(t(i) + h / 2, y(i) + k1y * h / 2, z(i) + k1z * h / 2);
        k2z = f2(t(i) + h / 2, y(i) + k1y * h / 2, z(i) + k1z * h / 2);
        k3y = f1(t(i) + h / 2, y(i) + k2y * h / 2, z(i) + k2z * h / 2);
        k3z = f2(t(i) + h / 2, y(i) + k2y * h / 2, z(i) + k2z * h / 2);
        k4y = f1(t(i) + h , y(i) + k3y * h, z(i) + k3z * h);
        k4z = f2(t(i) + h, y(i) + k3y * h, z(i) + k3z * h);
        
        y(i + 1) = y(i) + (k1y + 2 * k2y + 2 * k3y + k4y) * h / 6;
        z(i + 1) = z(i) + (k1z + 2 * k2z + 2 * k3z + k4z) * h / 6;
    end
end

