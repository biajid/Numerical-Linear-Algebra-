% Example 11-3: Temperature Distribution in a Pin Fin
%
% Determine the steady-state temperature distribution T(x) along a pin fin
% by solving the following second-order boundary-value problem using the
% finite difference method:
%
%       d^2T/dx^2 - (hc*P)/(k*Ac) * (T - Ts) = 0,
%       0 <= x <= L
%
% subject to the boundary conditions
%
%       T(0) = TA
%       T(L) = TB
%
% where
%   hc : convective heat-transfer coefficient
%   P  : perimeter of the fin cross section
%   k  : thermal conductivity of the fin material
%   Ac : cross-sectional area of the fin
%   Ts : surrounding air temperature
%
% Use the following parameter values:
%
%       L  = 0.1 m
%       T(0) = 473 K
%       T(L) = 293 K
%       Ts = 293 K
%
%       hc = 40 W/(m^2*K)
%       P  = 0.016 m
%       k  = 240 W/(m*K)
%       Ac = 1.6e-5 m^2
%
% Solve the boundary-value problem using the finite difference method.
% Divide the interval [0, L] into five equally spaced subintervals, and
% determine the temperature distribution at the resulting grid points.
%
% Plot the numerical temperature distribution along the length of the pin
% fin.

% Define the parameters
hc = 40; 
P = 0.016; 
k = 240; 
Ac = 1.6e-5; 
Ts = 293; 
L = 0.1; 
TA = 473; 
TB = 293;

beta = (hc * P) / (k * Ac);
h = 0.001;
x = 0 : h : L;
d = diag(ones(length(x) - 2, 1) * -(2 + h^2 * beta));
%disp(d);

superdiag = diag(ones(length(x) - 3, 1), 1);
subdiag = diag(ones(length(x) - 3, 1), -1);

A = d + superdiag + subdiag;
%disp(A);

b = -h ^ 2 * beta * Ts .* ones(length(x) - 2, 1);



b(1) = b(1) - TA;
b(end) = b(end) - TB;
%disp(b);

temperature = Tridiagonal(A, b);
temperature = [TA; temperature; TB];

%disp(temperature)

plot(x, temperature, 'r', 'LineWidth', 2);
xlabel('x (m)');
ylabel('Temperature (K)');
title('Temperature Distribution in a Pin Fin');
hold on;

% Now we will solve this system with Matlab's built-in bvp solver for comparison

%bc = @(Ta, Tb) [Ta(1) - TA; Tb(1) - TB];

%diffe = @(x, T) [T(2); beta * (T(1) - Ts)];
x = 0 : 0.01 : L;
solinit = bvpinit(x, [TA, -500]);
sol = bvp4c(@diffe, @bc, solinit);
%temperature_bvp = deval(sol, x);

plot(x, sol.y(1, :), 'k*', 'LineWidth', 2, 'MarkerSize', 8);
legend('Finite Difference', 'Matlab BVP Solver', 'Location', 'Best');

function res = bc(Ta, Tb)
    TA = 473;
    TB = 293;
    res = [Ta(1) - TA; Tb(1) - TB];
end

function res = diffe(x, T)
    beta = (40 * 0.016) / (240 * 1.6e-5);
    Ts = 293;
    res = [T(2); beta * (T(1) - Ts)];
end
