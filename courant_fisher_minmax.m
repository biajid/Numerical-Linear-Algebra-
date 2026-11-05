function [curr_lambda, curr_v] = courant_fisher_minmax(A, k, step_size, max_outer_iter)

	% This function gets the k-th eigenvalue and eigenvector pair of a symmetrix Matrix A.
	% usage : [lambda_k, v_k] = courant_fisher_minmax(A, k, step_size, max_outer_iter)
	% step_size and max_outer_iter are optional arguments.
	% lambda1 <= lambda2 <= ... <= lambda_k <= ...<= lambda_n
	
	if nargin < 3
		step_size = 0.05;
	end

	if nargin < 4 
		max_outer_iter = 2000;
	end

	A = (A + A') / 2;
	[n, ~] = size(A);

	V = randn(n, k); % We limit our search on k dimensional subspace. we get the maximum eigenvalue on this subspace, and then minimize it over all such k dimensional subspace--> the core of Courant_Fisher Algorithm.
	% code to be written here after completion of the local functions.

	Q = local_modified_GS(V);
	t = 0;

	for iter = 1 : max_outer_iter 
		M = Q' * A * Q;
		if iter > 1
			old_iter = curr_lambda;
		end
		[curr_lambda, curr_v] = local_power_iter(M);

		if iter > 1 
			if abs(old_iter - curr_lambda) < 1e-6
				t = t + 1;
			else 
				t = 0;
			end
		end
		 
		if t == 2 
			break;
		end

		grad_q = A * Q * curr_v * curr_v';
		Q = Q - step_size * grad_q;
		Q = local_modified_GS(Q);

		% just tracking the progress 
		if mod(iter, 100) == 0
			fprintf("Iteration %d : max R(x) = %f\n", iter, curr_lambda);
		end
	end

	M = Q' * A * Q;
	[curr_lambda, curr_v] = local_power_iter(M, 200);

	% mapping back to R^{n};
	curr_v = Q * curr_v;
	curr_v = curr_v / norm(curr_v);

end

% Local functions 


function [lambda, y] = local_power_iter(A, n)

	if nargin < 2 
		n = 100;
	end

	k = size(A, 1);
	y = randn(k, 1);
	y = y / norm(y);

	s = max(sum(abs(A), 2));
	Ashifted = A + s * eye(k);
	
	lambda_old = y' * Ashifted * y;


	for index = 1 : n
		y = Ashifted * y;
		y = y / norm(y);
		lambda = y' * Ashifted * y;
		if abs(lambda - lambda_old) < 1e-6 
			break;
		end

		lambda_old = lambda;
	end

	lambda = lambda - s;
	
end


function Q = local_modified_GS(A)
	[n, k] = size(A);
	Q = zeros(n, k);

	for index = 1 : k 
		current_vector = A(:, index);

		for jj = 1 : index - 1 
			r = Q(:, jj)' * current_vector;
			current_vector = current_vector - r * Q(:, jj);
		end
		Q(:, index) = current_vector / norm(current_vector);
	end
end



