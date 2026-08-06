% y'' = -y + 2 * cos(t); y(0) = 0; y(π) = 0;
yexact = @(t) t .* sin(t);
t = linspace(0, pi, 25);
plot(t, yexact(t), '*r', 'MarkerSize', 8);
xlabel('t')
ylabel('y')
title('Boundary Value Problem 72')
grid on
hold on;

% let y' = w; w' = -y + 2 * cos(t)

f1 = @(t, y, w) w;
f2 = @(t, y, w) -y + 2 * cos(t);
t0 = 0;
tf = pi;
h = 0.125 / 8;
y0 = 0;
m0 = -0.5; % Just an educated guess..
m1 = 0.5; % another guess..
yend = 0;


addpath('..');

[t1, y1, w1] = sys2odesRK2(f1, f2, t0, tf, y0, m0, h);
[t2, y2, w2] = sys2odesRK2(f1, f2, t0, tf, y0, m1, h);

err0 = y1(end) - yend;
err1 = y2(end) - yend;

while abs(err1) > 1e-4
    m = m1 - err1 * (m1 - m0) / (err1 - err0);
    m0 = m1;
    err0 = err1;
    m1 = m;
    
    [t2, y2, w] = sys2odesRK2(f1, f2, t0, tf, y0, m1, h);
    err1 = y2(end) - yend;
    if abs(err1) < 1e-4
        break;
    end 
end

plot(t2, y2, 'k', 'LineWidth', 1.5);
xlabel('t');
ylabel('y');
title('Boundary Value Problem 72');
grid on;
hold on;
%legend('Analytical Solution', 'Numerical Solution', 'Location', 'best');

solinit = bvpinit(t2, @guess);
% get the solution using bvp4c
sol = bvp4c(@f, @bcn, solinit);

plot(sol.x, sol.y(1, :), 'b', 'LineWidth', 1.5);
legend('Analytical Solution', 'Numerical Solution','Matlab Solution', 'Location', 'best');

function dydt = f(x, yw)
    dydt = [yw(2); -yw(1) + 2 * cos(x)];
end 

function out = bcn(ya, yb)
    out = [ya(1); yb(1)];
end

function out = guess(t)
    out = [t .* sin(t); sin(t) + cos(t)];
end
% comment : This boundary value problem does not have 
% an unique solution!
