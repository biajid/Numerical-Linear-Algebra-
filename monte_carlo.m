function I = monte_carlo(f, a, b, N)
	%Usage : monte_carlo(f, a, b, N)
	%step 1: sample U ~ Uniform(a, b)
	U = a + (b - a) * rand(N, 1);

	%step 2: evaluate the function
	fU = feval(f, U);

	%step 3: average and scale
	I = (b - a) * mean(fU);

end

