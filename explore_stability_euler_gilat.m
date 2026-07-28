% We are exploring stiffness in the differential equation 
% dy/dx = -2.5 * y; 
% Initial condition : y(0) = 1;
% 0 < x < 3.4;
% h should be, |2.1 - h * 2.5| < 1, h < 2 / 2.5 = 0.8;

a = 0; b = 3.4;
alpha = 2.5;
ha = 0.2; hb = 0.85;
dydx = @(y) -2.5 .* y;

na = (b - a) / ha;
nb = (b - a) / hb;

xa = zeros(1, na + 1);
ya = zeros(1, na + 1);
xb = zeros(1, nb + 1);
yb = zeros(1, nb + 1);

xa(1) = a; ya(1) = 1; 
xb(1) = a; yb(1) = 1;

for i = 2 : na 
    xa(i) = xa(i - 1) + ha;
    ya(i) = ya(i - 1) + ha * dydx(ya(i - 1));
end

for i = 2 : nb 
    xb(i) = xb(i - 1) + hb;
    yb(i) = yb(i - 1) + hb * dydx(yb(i - 1));
end

xtrue = a : 0.05 : b;
ytrue = exp(-2.5 .* xtrue);

figure("Name", "Stability of Euler Method");
plot(xa, ya, 'ro--', xb, yb, '*b--', xtrue, ytrue, 'k', 'LineWidth', 2);
legend('h = 0.2', 'h = 0.85', 'Exact Solution');
xlabel('x');
ylabel('y');
title('Stability of Euler Method for dy/dx = -2.5y');




