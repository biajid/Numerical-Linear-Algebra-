function [m, b] = num_real_eigenvalues(A)
	% This function computes the eigenvalues of the given matrix, and returns the number of real eigenvalues. 

	b = eig(A);
	m = length(find(abs(imag(b)) < 1e-6));
end

