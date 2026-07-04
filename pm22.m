function [eigen_value, eigen_vector] = pm22(A)
	[m, n] = size(A);
	
	if (m ~= n)
		error('Matrix needs to be a square matrix');
	end

	iter = 1;
	tolerance = 1e-12;
	x_0 = ones(n, 1);
	x_0 = x_0 / norm(x_0);
	
	while(iter < 1000)
		x_1 = A * x_0;
		x_1 = x_1 / norm(x_1);
		if (norm(x_0 - x_1)) < tolerance
			eigen_vector = x_1;
			eigen_value = x_1' * A * x_1;
			iter
			break
		end
		x_0 = x_1;
		iter = iter + 1;
	end

	if(iter > 1000)
		error("Max Iteration has been reached but no result!");
	end

end