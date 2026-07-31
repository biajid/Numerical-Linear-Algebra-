function [t, y2, y3, y4] = adams_bashforth_234(f, t0, tf, y0, h)
    % This function implements the Adams-Bashforth methods of order 2, 3, and 4
    % to solve the initial value problem dy/dt = f(t, y) with initial condition y0
    % over the interval [t0, tf] using step size h.
    %
    % Inputs:
    %   f  - function handle for the ODE, f(t, y)
    %   t0 - initial time
    %   tf - final time
    %   y0 - initial value (column vector)
    %   h  - step size
    %
    % Outputs:
    %   t  - vector of time points
    %   y2 - solution using the 2nd-order Adams-Bashforth method
    %   y3 - solution using the 3rd-order Adams-Bashforth method
    %   y4 - solution using the 4th-order Adams-Bashforth method

    n = floor((tf - t0) / h);
    h = (tf - t0) / n;

    t = zeros(1, n + 1);
    y2 = zeros(1, n + 1);
    y3 = zeros(1, n + 1);
    y4 = zeros(1, n + 1);

    t(2) = t0 + h;
    t(3) = t0 + 2 * h;
    t(4) = t0 + 3 * h;

    t(1) = t0; 
    [y2(1), y3(1), y4(1)] = deal(y0);
    for i = 2 : 4
        k1 = f(t(i-1), y2(i-1));
        k2 = f(t(i), y2(i - 1) + k1 * h);
        y2(i) = y2(i - 1) + (h / 2) * (k1 + k2);
    end 

    [~, y3(1 : 4)] = runge_kutta_3(f, t(1), t(4), y3(1), h);
    [~, y4(1 : 4)] = runge_kutta4(f, t(1), t(4), y4(1), h);



    

    for i = 4 : n 
        t(i + 1) = t(i) + h;
        y2(i + 1) = y2(i) + (h / 2) * (3 * f(t(i), y2(i)) - f(t(i-1), y2(i-1)));
        y3(i + 1) = y3(i) + (h / 12) * (23 * f(t(i), y3(i)) - 16 * f(t(i-1), y3(i-1)) + 5 * f(t(i-2), y3(i-2)));
        y4(i + 1) = y4(i) + (h / 24) * (55 * f(t(i), y4(i)) - 59 * f(t(i-1), y4(i-1)) + 37 * f(t(i-2), y4(i-2)) - 9 * f(t(i-3), y4(i-3)));
    end

end
