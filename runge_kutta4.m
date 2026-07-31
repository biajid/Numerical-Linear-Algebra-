function [x, y] = runge_kutta4(f, t0, tf, y0, h)
    % RUNGE_KUTTA4 Solves an ODE using the classical fourth-order Runge-Kutta method.
    %
    %   [t, y] = RUNGE_KUTTA4(f, t0, tf, y0, h) integrates the system of ODEs
    %   dy/dt = f(t, y) from t0 to tf with initial condition y0 using step size h.
    %
    %   Inputs:
    %       f  - function handle for the ODE, f(t, y)
    %       t0 - initial time
    %       tf - final time
    %       y0 - initial value (column vector)
    %       h  - step size
    %
    %   Outputs:
    %       t - vector of time points
    %       y - matrix of solution values, each row corresponds to a time point
    n = floor((tf - t0) / h);
    h = (tf - t0) / n;

    % Now define the vectors t and y;
    x = zeros(1, n + 1);
    y = zeros(1, n + 1);

    x(1) = t0; y(1) = y0;

    for i = 1 : n 
        x(i + 1) = x(i) + h;
        k1 = f(x(i), y(i));
        k2 = f(x(i) + (1 / 2) * h, y(i) + (1 / 2) * k1 * h);
        k3 = f(x(i) + (1/2) * h, y(i) + (1 / 2) * k2 * h);
        k4 = f(x(i) + h, y(i) + k3 * h);

        y(i + 1) = y(i) + (k1 + 2 * k2 + 2 * k3 + k4) * h / 6;
    end
end
