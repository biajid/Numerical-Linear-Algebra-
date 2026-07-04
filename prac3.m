a = -2 : 0.2 : 2;
[x, y] = meshgrid(a, a);
z = exp(-x.^2 - y.^2);

figure;
subplot(1, 2, 1);
mesh(x, y, z);
xlabel('x');
zlabel('-x^2 - y^2');
ylabel('y');
title('Mesh');
shading interp;
colormap hot;
subplot(1, 2, 2);
surf(x, y, z);
xlabel('x');
zlabel('-x^2 - y^2');
ylabel('y');
title('Surface');

%Done for now;

