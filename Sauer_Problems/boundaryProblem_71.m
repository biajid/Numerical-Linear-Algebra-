% Differential Equation :: y'' = -g; y(0) = 30; y(4) = 0;
% guess a velocity 
v_guess1 = 15; 
v_guess2  = 30; 
f1 = @(t, y, z) z;
f2 = @(t, y, z) -9.8;
%t = linspace(0, 4);
addpath('..');
h = 0.05;
[t, y, ~] = sys2odesRK2(f1, f2, 0, 4, 30, v_guess1, h);
[t2, y2, ~] = sys2odesRK2(f1, f2, 0, 4, 30, v_guess2, h);

while abs(y2(end)) > 1e-4
    slope = (v_guess2 - v_guess1) / (abs(y2(end)) - abs(y(end)));
    v_guess = v_guess2 - slope * y2(end);
    [t, yn, ~] = sys2odesRK2(f1, f2, 0, 4, 30, v_guess, h);

    if abs(yn(end)) < 1e-4
        y = yn;
        break;
    end

    v_guess1 = v_guess2;
    v_guess2 = v_guess;
    y = y2;
    y2 = yn;
end

plot(t, y, 'r', 'LineWidth', 2);
xlabel('Time')
ylabel('Position')
title('Projectile Motion')
grid on
hold on;

yexact = @(t) 30 + 12.12 .* t - 4.9 .* t.^2;
tt = linspace(0, 4, 10);
plot(tt, yexact(tt), 'k*', 'MarkerSize', 8);
legend('Numerical', 'Exact')
