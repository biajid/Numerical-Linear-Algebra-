function [eigen_value, eigen_vector] = pm33(A, guess)
	[m, n] = size(A);
	sigma = guess;
	
	if (m ~= n)
		error('Matrix needs to be a square matrix');
	end

	iter = 1;
	tolerance = 1e-12;
	x_0 = ones(n, 1);
	x_0 = x_0 / norm(x_0);
	W = A - sigma * eye(n);
	[L, U, P] = lu(W);

	% PA = LU
	% Ax = b => PAx = Pb => LUx = Pb, Ly = Pb
	% y = L \ (Pb) , Ux = y, x = U \ y.

	while(iter < 1000)
		y = L \ (P * x_0);
		x = U \ y;
		x_1 = x / norm(x);
		if (norm(x_0 - x_1)) < tolerance
			eigen_vector = x_1;
			eigen_value = x_1' * A * x_1;
			break
		end
		x_0 = x_1;
		iter = iter + 1;
	end

	if(iter > 1000)
		error("Max Iteration has been reached but no result!");
		exit(2);
	end

end