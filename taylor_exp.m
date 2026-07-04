function result = taylor_exp(x, tolerance)
	%This function continues to evaluate taylor series for exp(x)
	%until term < tolerance
	if (nargin < 2) 
		tolerance = 1e-6;
	end
	k = 1;
	term = 1;
	result = 1;

	while(abs(term) > tolerance)
		term = (x ^ k) / factorial(k);
		result = result + term;
		k = k + 1;
	end


