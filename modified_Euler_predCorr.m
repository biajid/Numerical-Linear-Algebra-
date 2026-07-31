function [t, y] = modified_Euler_predCorr(f, t0, tf, y0, h, tolerance)
    % This function implements the modified Euler method (predictor-corrector) 
    % to solve the initial value problem dy/dt = f(t, y) with initial condition y0
    % over the interval [t0, tf] using step size h.
    %
    % Inputs:
    %   f  - function handle for the ODE, f(t, y)
    %   t0 - initial time
    %   tf - final time
    %   y0 - initial value (column vector)
    %   h  - step size
    %   tolerance : optional
    % 
    %
    % Outputs:
    %   t  - vector of time points
    %   y  - solution vector
    % Usage: [t, y] = modified_Euler_predCorr(f, t0, tf, y0, h, tolerance);

    if nargin < 6
        tolerance = 1e-6;
    end

    n = floor((tf - t0) / h);

    h = (tf - t0) / n;

    t = zeros(1, n + 1);
    y = zeros(1, n + 1);
    t(1) = t0;
    y(1) = y0;

    for i = 1 : n
        t(i + 1) = t(i) + h;
        p = y(i) + h * f(t(i), y(i));
        while true
            
            c = y(i) + (f(t(i), y(i)) + f(t(i + 1), p)) * (h / 2);

            if abs((c - p) / p) <= tolerance
                break;
            end
            p = c;
        end
        y(i + 1) = c;
    end

end
