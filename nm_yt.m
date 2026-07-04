f = @(x) x .^ 2 - 2;
fdiff = @(x) 2 .* x;

t = 0.1 : 0.01 : 10;
y = f(t);

x0 = 9.8;

iteration = 1000;
xnext = x0;
guess = [x0];
disp(xnext);

for i = 1 : iteration
	xnext = xnext - f(xnext) / fdiff(xnext);
	disp(xnext);
	guess = [guess, xnext];
	pause(0.5);
	if (abs(f(xnext)) < 1e-10)
		break;
	end
end

disp("With " + i + " iterations of newton method");
disp("root = " + xnext);
disp("Error =  " + abs(sqrt(2) - xnext));


figure;
plot(t, y, 'k--', 'LineWidth', 2);
hold on;
plot(guess, f(guess), 'ro', 'LineWidth', 3);
hold off;