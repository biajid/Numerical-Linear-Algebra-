function out = poisson_dist(lambda, k)
	% Usage : 1st Param: lambda,  2nd Param: even_count k
	out = exp(-lambda) * (lambda)^k;
	out = out / factorial(k);
end

