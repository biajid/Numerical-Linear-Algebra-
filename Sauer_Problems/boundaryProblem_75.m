% y'' = 4 .* y; y(0) = 1; y(1) = 3;
yexact = @(t) (3 - exp(-2)) / (exp(2) - exp(-2)) * exp(2 .* t) + ...
    (exp(2) - 3) / (exp(2) - exp(-2)) * exp(-2 .* t);

t = linspace(0, 1, 25);
% plot the curve
plot(t, yexact(t), '*r', 'MarkerSize', 8);
xlabel('t');
ylabel('y');
title('Boundary Value Problem 75');
grid on;
hold on;

f1 = @(t, y, w) w;
f2 = @(t, y, w) 4 * y;
% Now we will solve it using shooting method
h = 0.125 / 8;
t0 = 0; tf = 1;
y0 = 1;
yend = 3;

guess1 = -1; 
guess2 = -2;

[t1, y1, w1] = sys2odesRK2(f1, f2, t0, tf, y0, guess1, h);
[t2, y2, w2] = sys2odesRK2(f1, f2, t0, tf, y0, guess2, h);

err1 = y1(end) - yend;
err2 = y2(end) - yend;

while abs(err2) > 1e-6
    guess = guess1 - err1 * (guess2 - guess1) / (err2 - err1);
    [t, y, w] = sys2odesRK2(f1, f2, t0, tf, y0, guess, h);
    err = y(end) - yend;
    guess1 = guess2;
    err1 = err2;
    guess2 = guess;
    err2 = err;
    fprintf("Guess: %f, Error: %f\n", guess, err);
end

plot(t, y, 'k', 'LineWidth', 1.5);
legend('Exact Solution', 'Numerical Solution', 'Location', 'best');
