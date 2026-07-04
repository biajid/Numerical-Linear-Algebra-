function [eigen_value, eigen_vector] = pm44(A, guess)
	[m, n] = size(A);
	l = length(guess);
		
	if (m ~= n | n ~= l)
		error('Size Mismatch!');
	end

	iter = 1;
	tolerance = 1e-12;
	x_0 = guess;
	x_0 = x_0 / norm(x_0);
	%W = A - sigma * eye(n);
	%[L, U, P] = lu(W);

	% PA = LU
	% Ax = b => PAx = Pb => LUx = Pb, Ly = Pb
	% y = L \ (Pb) , Ux = y, x = U \ y.
	lambda = x_0' * A * x_0;


	while(iter < 1000)
		x_1 = (A - lambda * eye(n)) \ x_0;
		x_1 = x_1 / norm(x_1);
		if (norm(x_0 - x_1)) < tolerance
			eigen_vector = x_1;
			eigen_value = x_1' * A * x_1;
			break
		end
		x_0 = x_1;
		iter = iter + 1;
		lambda = x_0' * A * x_0;
	end

	if(iter > 1000)
		error("Max Iteration has been reached but no result!");
		exit(2);
	end

end