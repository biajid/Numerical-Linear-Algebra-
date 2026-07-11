function [Q, R] = modified_gramschmidt(A)
	[m, n] = size(A);
	if m < n 
		error("Method would not work!");
	end

	Q = zeros(m, n);
	R = zeros(n, n);

	for k = 1 : n 
		R(k, k) = norm(A(:, k));
		Q(:, k) = A(:, k) / R(k, k);

		for j = k + 1 : n 
			R(k, j) = Q(:, k)' * A(:, j);
			A(:, j) = A(:, j) - R(k, j) * Q(:, k);
		end
	end
end
