% Example 11-2: Temperature Distribution in a Pin Fin
%
% Solve the boundary-value problem given in Example 11-1 using the
% shooting method together with the secant method.
%
% The secant method is used to determine the correct estimate of the
% unknown initial slope w(0).
%
% Begin by solving the initial-value problem using the two initial-slope
% estimates
%
%       w(0) = -1000
%
% and
%
%       w(0) = -3500.
%
% 
% Stop the iterations when the absolute difference between the calculated
% temperature at x = 0.1 and the prescribed boundary temperature is less
% than 0.01 K.
%
% Plot the final numerical temperature distribution along the pin fin.


% first put all the constants
a = 0; b = 0.1; TINI = 473; WINI1 = -1000; WINI2 = -3500;
h = 0.01; Ts = 293;
ssb = 5.67 * 1e-8; hc = 40; p = 0.016; sgma = 0.4; k = 240; Ac = 1.6 * 1e-5;
% We also need the function f1, and f2 which define the system of first-order ODEs
Tb = 293; % Target temperature at x = 0.1
f1 = @(x, T, w) w;
f2 = @(x, T, w) hc * p * (Ts - T) / (k * Ac) - ssb * sgma * p * (T^4 - Ts^4) / (k * Ac);
[t, T1, w1] = sys2odesRK2(f1, f2, a, b, TINI, WINI1, h);
fprintf("The temperature at x = 0.1 is %5.3f K\n and slope at the initial point is %5.3f\n", T1(end), w1(1));
[t, T2, w2] = sys2odesRK2(f1, f2, a, b, TINI, WINI2, h);

fprintf("The temperature at x = 0.1 is %5.3f K\n and slope at the initial point is %5.3f\n", T2(end), w2(1));

% Now we will apply secant method here .. 
temperature = T2(end); 
error_temp1 = T1(end) - Tb;
error_temp2 = T2(end) - Tb;



while abs(error_temp2) > 0.01
    slope = (WINI1 - WINI2) / (error_temp1 - error_temp2);
    wnew = WINI2 - slope * error_temp2;
    [x, T, w] = sys2odesRK2(f1, f2, a, b, TINI, wnew, h);
    fprintf("\nThe temperature at x = 0.1 is %5.3f K\n and slope at the initial point is %5.3f\n", T(end), w(1));

    error_temp1 = error_temp2;
    error_temp2 = T(end) - Tb;
    WINI1 = WINI2;
    WINI2 = wnew;
end

plot(x, T, 'Color', 'red', 'LineWidth', 1.5);
xlabel('x (m)');
ylabel('Temperature (K)');
title('Temperature Distribution along the Pin Fin');
%grid on;
%legend('Temperature Distribution');
hold on;




% Now we will verify our solution with Matlab built-in boundary value problem solver, bvp4c.
% for matlab, we need to define the ODE function and boundary conditions for bvp4c.
odefun = @(x, Y) [Y(2); hc * p * (Ts - Y(1)) / (k * Ac) - ssb * sgma * p * (Y(1)^4 - Ts^4) / (k * Ac)];
bcfun = @(ya, yb) [ya(1) - TINI; yb(1) - Tb];
solinit = bvpinit(linspace(a, b, 11), [TINI, WINI1]);
sol = bvp4c(odefun, bcfun, solinit);

plot(sol.x, sol.y(1, :), 'k*', 'LineWidth', 2, 'MarkerSize', 8);
legend('Shooting Method Using Secant Method', 'bvp4c Solution');
grid on;

% Maximum error in the calculation 
err = max(abs(T - sol.y(1, :)));
fprintf("Maximum error between shooting method and bvp4c solution is %5.3f K\n", err);


