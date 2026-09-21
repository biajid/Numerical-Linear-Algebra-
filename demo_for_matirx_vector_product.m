A = [0 2 1;
    0 1 0;
    2 0 0];

x = zeros(3, 1);

for k = 1 : 1000
    x = rand(3, 1) - 0.5;
    x = x / norm(x);

    y = A * x;
    subplot(1, 2, 1);
    hold on;
    plot3(x(1), x(2), x(3), '.r');
    axis('equal');
    xlabel('x1');
    ylabel('x2');
    zlabel('x3');
    grid on;
    view(3);
    subplot(1, 2, 2);
    hold on;
    plot3(y(1), y(2), y(3), '.b');
    axis('equal');
    xlabel('y1');
    ylabel('y2');
    zlabel('y3');
    grid on;
    view(3);
    drawnow;
end