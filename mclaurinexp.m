function [out, ideal, error_percentage, error] = mclaurinexp(x, n)
	vec = 1 : n;
	out = (x .^ vec) ./ cumprod(vec);
	out = 1 + sum(out);
	ideal = exp(x);
	error = abs(ideal - out);
	error_percentage = abs(ideal - out) / out * 100;
end
