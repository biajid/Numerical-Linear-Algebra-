function [out, iteration] = nr2(xguess, fun, fun_prime)
	for i = 1 : 10000
		out = xguess - fun(xguess) / fun_prime(xguess);
		if abs(fun(out)) <= 1e-5
			break;
		end

		xguess = out;
		iteration = i;
	end

	if iteration == 10000
		error('Max iteration has been reached!');
	else
		disp(['The solution is : ', num2str(xguess, 10), ' and'...
			' iteration count : ', num2str(iteration)]);
	end
end