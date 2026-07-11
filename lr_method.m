function out = lr_method(A)
	% This method will return the eigenvalue
	% of the matrix A if it succeeds
	[L, R] = doolittle_lu(A);

	A1 = R * L;
	n = 1;
	[m, ~] = size(A);

	while check_ut(A1) ~= true
		A = A1;
		[L, R] = doolittle_lu(A);
		A1 = R * L;
		n = n + 1;
		if n > 100 * m
			error("Method failed!");
		end
	end


	out = sort(diag(A1), 'descend');
	end
