function plotfunction(f, x)
	y = feval(f, x);
	plot(x, y, 'ro--', 'LineWidth', 2);
end


