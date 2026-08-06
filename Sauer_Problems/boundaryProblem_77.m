% Given Equation: y1' = (4 - 2 * y2) / t ^ 3;
% y2' = -exp(y1); y1(1) = 0; y2(2) = 0; t belongs to [1, 2]

y1exact = @(t) log(t);
y2exact = @(t) 2 - t .^ 2 / 2;

t = linspace(1, 2, 10);
plot(t, y1exact(t), '*r', 'MarkerSize', 8);
hold on;
plot(t, y2exact(t), '*b', 'MarkerSize', 8);
%legend('y1 Exact Solution', 'y2 Exact Solution', 'Location', 'best');

f1 = @(t, y, w) (4 - 2 * w) / t ^ 3;
f2 = @(t, y, w) -exp(y);

h = 0.125 / 8;

t0 = 1; tf = 2;
y0 = 0; wend = 0;

guess1 = 0;
guess2 = 1;

addpath('..');
[t1, y1, w1] = sys2odesRK2(f1, f2, t0, tf, y0, guess1, h);
[t2, y2, w2] = sys2odesRK2(f1, f2, t0, tf, y0, guess2, h);

err1 = w1(end) - wend;
err2 = w2(end) - wend;
y = y2; t = t2; w = w2;
while abs(w2(end) - wend) > 1e-4
    s = (err2 - err1) / (guess2 - guess1);
    guess = guess2 - err2 / s;
    guess1 = guess2;
    guess2 = guess;
    [t, y, w] = sys2odesRK2(f1, f2, t0, tf, y0, guess, h);
    err1 = err2;
    err2 = w(end) - wend;

    if abs(err2) < 1e-4
        break;
    end 
end


plot(t, y, 'k', t, w, 'r', 'LineWidth', 2);
xlabel('time')
ylabel('solution')
title('Boundary Value Problem Solution');
legend('y1 Exact Solution', 'y2 Exact Solution', 'y1 Numerical Solution', 'y2 Numerical Solution','Location', 'best');

