function G = cholesky(A)
	if ~isequal(A, A')
		error('Matrix A is not symmetric');
	end
	[m, n] = size(A);
	G = zeros(n, n);

	% In cholesky we go row by row
	for i = 1 : n 
		for j = 1 : i 
			if i == j 
				sum_sq = G(i, 1 : i-1) * G(i, 1 : i-1)';
				sum_sq = A(i, i) - sum_sq;
				if (sum_sq < 0)
					error('cholesky Factorization not possible!')
				
				else
					G(i, i) = sqrt(sum_sq);
				end
			else
				sum_sq = G(i, 1 : j - 1) * G(j, 1 : j -1)';
				sum_sq = A(i, j) - sum_sq;
				G(i, j) = sum_sq / G(j, j);
				G(i, j) = G(j, i);
			end
		end
	end
			

		

end