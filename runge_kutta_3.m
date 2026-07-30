function [t, y] = runge_kutta_3(f, t0, tf, y0, h)
    % RUNGE_KUTTA_3 Solves an ODE using the classical third-order Runge-Kutta method.
    %
    %   [t, y] = RUNGE_KUTTA_3(f, t0, tf, y0, h) integrates the system of ODEs
    %   dy/dt = f(t, y) from t0 to tf with initial condition y0 using step size h.
    %
    %   Inputs:
    %       f  - function handle for the ODE, f(t, y)
    %       t0 - initial time
    %       tf - final tim
    %       y0 - initial value (column vector)
    %       h  - step size
    %
    %   Outputs:
    %       t - vector of time points
    %       y - matrix of solution values, each row corresponds to a time point
    
    n = floor((tf - t0) / h);
    h = (tf - t0) / n;

    t = zeros(1, n + 1);
    y = zeros(1, n + 1);
    t(1) = t0; y(1) = y0;

    for i = 1 : n 
        t(i + 1) = t(i) + h;
        k1 = f(t(i), y(i));
        k2 = f(t(i) + (1 / 2) * h, y(i) + (1 / 2) * k1 * h);
        k3 = f(t(i) + h, y(i) - k1 * h + 2 * k2 * h);

        y(i + 1) = y(i) + (1 / 6) * (k1 + 4 * k2 + k3) * h;
    end
end


