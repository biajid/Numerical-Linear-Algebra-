function [out, iteration] = nr2(xguess, fun)
	for i = 1 : 10000
		fun_prime = (fun(xguess + 0.0001) - fun(xguess)) / 0.0001;
		out = xguess - fun(xguess) / fun_prime;
		if abs(fun(out)) <= 1e-10
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