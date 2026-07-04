function result = trapint(x, f)
	int = 0;
	N = length(f);

	for k = 1 : N - 1
		temp = (f(k + 1) + f(k)) * (x(k + 1) - x(k));
		int = int + temp ./ 2;
	end
	
	result = int;

end

