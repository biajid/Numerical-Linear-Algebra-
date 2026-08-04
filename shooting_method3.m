clear; clc; 

solinit = bvpinit(linspace(0, 1, 20), [0.2, 0.2]);
sol = bvp4c(@ode_fun, @residue_fun, solinit);

figure("Name", "Matlab BVP Solver");
plot(sol.x, sol.y(1, :), 'r', 'LineWidth', 2);
xlabel('x');
ylabel('Y(x)');
grid on;
hold on;
a = 0; b = 1; y_a = 1; y_b = 0.5;
plot([a, b], [y_a, y_b], 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
legend('Numerical Solution', 'Boundary Conditions');
title('Usage of Matlab builtin boundary value equation solver.');



function dydx = ode_fun(x, yw)
    dydx = [yw(2);
    2 .* yw(1) .^ 3;
    ];
end

function residue = residue_fun(ya, yb)
    residue = [ya(1) - 1;
    yb(1) - 0.5];
end
    