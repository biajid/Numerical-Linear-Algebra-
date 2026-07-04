function x = newraph1(f, fprime, guess, tolerance, iteration)
	x(1) = guess;
	for i = 1 : iteration
		x(i+ 1) =  x(i) - f(x(i)) ./ fprime(x(i));
		if abs(f(x(i+1))) <= tolerance
			break;
		end
	end

