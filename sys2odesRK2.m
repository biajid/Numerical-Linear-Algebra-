function [t, y, z] = sys2odesRK2(f1, f2, t0, tf, y0, z0, h)
    % This function solves a system of two first-order ordinary differential equations
    % dy/dt = f1(t, y, z) and dz/dt = f2(t, y, z) using the second-order Runge-Kutta method (RK2)
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
    % Usage: [t, y, z] = sys2odesRK2(f1, f2, t0, tf, y0, z0, h);
    n = floor((tf - t0) / h);
    h = (tf - t0) / n;

    t = zeros(1, n + 1);
    y = zeros(1, n + 1);
    z = zeros(1, n + 1);
    t(1) = t0;
    y(1) = y0;
    z(1) = z0;

    for i = 1 : n 
        t(i + 1) = t(i) + h;
        k1y = f1(t(i), y(i), z(i));
        k1z = f2(t(i), y(i), z(i));
        k2y = f1(t(i) + h, y(i) + k1y * h, z(i) + k1z * h);
        k2z = f2(t(i) + h, y(i) + k1y * h, z(i) + k1z * h);
        y(i + 1) = y(i) + (h / 2) * (k1y + k2y);
        z(i + 1) = z(i) + (h / 2) * (k1z + k2z);
    end
end

