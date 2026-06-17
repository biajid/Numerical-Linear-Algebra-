function [L, U] = doolittle_lu(A)
	% This function computes the LU Decomposition of the given square matrix A. 
	% First check the size of the matrix => If it is not a square matrix, exit immediately. 
	[m, n] = size(A);
	
	if (m ~= n)
		error('Matrix is not square!');
	end

	% Get the memory for L and U
	% L is unit lower triangular matrix, so it has one on its diagonal.
	L = eye(n);
	U = zeros(n);

	% Now we will compute the l and u components. 
	% In this doolittle method, we traverse column by column on A. 
	% Top half the column generates u element, and lower half of the columns generate the l component. 

	for j = 1 : n 

		% First traverse the top half of the column    i >= j 

		for i = 1 : j
			% Now get the each u(i, j) elements.
			dummy = 0;

			for k = 1 : i - 1
				dummy = dummy + L(i, k) * U(k, j);
			end

			U(i, j) = A(i, j) - dummy;
		end

		for i = j+1 : n 
			dummy = 0;
			for k = 1 : j - 1
				dummy = dummy + L(i, k) * U(k, j);
			end
			L(i, j) = (A(i, j) - dummy) / U(j, j);
		end


end