% Example 11-4: Temperature Distribution in a Pin Fin
%
% Determine the steady-state temperature distribution T(x) along a pin fin
% by solving the following second-order nonlinear boundary-value problem
% using the finite difference method:
%
%       d^2T/dx^2
%       - (hc*P)/(k*Ac) * (T - Ts)
%       - (epsilon*sigma*SB*P)/(k*Ac) * (T^4 - Ts^4) = 0,
%
%       0 <= x <= L
%
% subject to the boundary conditions
%
%       T(0) = TA
%       T(L) = TB
%
% where
%   hc      : convective heat-transfer coefficient
%   P       : perimeter of the fin cross section
%   k       : thermal conductivity of the fin material
%   Ac      : cross-sectional area of the fin
%   epsilon : surface emissivity
%   sigmaSB : Stefan-Boltzmann constant
%   Ts      : surrounding air temperature
%
% The definitions and numerical values of all constants are the same as
% those given in Example 11-2.
%
% Use the following boundary conditions:
%
%       L    = 0.1 m
%       T(0) = 473 K
%       T(L) = 293 K
%       Ts   = 293 K
%
% Solve the nonlinear boundary-value problem using the finite difference
% method. Divide the interval [0, L] into five equally spaced subintervals,
% determine the temperature at each grid point, and plot the resulting
% temperature distribution along the pin fin.
% write all the parameters as variables for later use
L = 0.1;
TA = 473;
TB = 293;
Ts = 293;   
hc = 40;          % example value for convective heat-transfer coefficient
P = 0.016;        % example value for perimeter of the fin cross section
k = 240;         % example value for thermal conductivity of the fin material
Ac = 1.6e-5;       % example value for cross-sectional area of the fin
epsilon = 0.4;   % example value for surface emissivity
sigmaSB = 5.67e-8; % Stefan-Boltzmann constant

betaA = (hc*P)/(k*Ac);
betaB = (epsilon*sigmaSB*P)/(k*Ac);
h = 0.001;

x = 0 : h : L;

n = length(x) - 2;

T = zeros(n + 2, 1);
T(1) = TA;
T(end) = TB;

term = -(2 + betaA * h ^ 2);
d_diag = ones(n, 1) * term;

d_diag = diag(d_diag);

sub_diag = diag(ones(n - 1, 1), -1);
super_diag = diag(ones(n - 1, 1), 1);

A = d_diag + sub_diag + super_diag;
b = - (h ^ 2 * (betaA * Ts + betaB * Ts ^ 4)) * ones(n, 1);
b(1) = b(1) - TA; 
b(end) = b(end) - TB;

guess = linspace(TA - (TA - TB) / (n + 1), TB + (TA - TB) / (n + 1), n);
guess = guess';
%guess

while true
    phi = h ^ 2 .* betaB .* guess .^ 4;
    %guess
    Temp = Tridiagonal(A, b + phi);
    %A
    %Temp
    if norm(guess - Temp) < 1e-3
        break;
    end
    guess = Temp;
end

T(2 : end - 1) = Temp;
plot(x, T, 'r', 'LineWidth', 1.5);
xlabel('Position in m');
ylabel('Temperature in K');
title('Temperature Distribution Along the Pin Fin');
hold on;

% Now we will put points with bvp4c
fun = @(x, T) [T(2); betaA * (T(1) - Ts) + betaB * (T(1)^4 - Ts^4)];

bc = @(tA, tB) [tA(1) - TA; tB(1) - TB];
x = 0 : 0.02 : L;

solinit = bvpinit(x, [TA; (TB - TA) / L]);
sol = bvp4c(fun, bc, solinit);
T_bvp4c = deval(sol, x);
plot(x, T_bvp4c(1, :), 'k*', 'MarkerSize', 8);
legend('Finite Difference', 'bvp4c');
grid on;



