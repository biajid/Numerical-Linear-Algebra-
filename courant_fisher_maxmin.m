function [curr_lambda, curr_v] = courant_fisher_maxmin(A, k, step_size, max_outer_iter)
	% This function gets the kth eigenvalue-eigenvector
	% pair of a symmetric matrix using Courant_Fisher Maxmin procedure.
	% usage : [lambda_k, v_k] = courant_fisher_maxmin(A, k, step_size, max_outer_iter)
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

	% subspace dimension for maxmin is (n - k + 1)
	m = n - k + 1;
	V = randn(n, m);
	Q = local_modified_GS(V);
	t = 0;

	for iter = 1 : max_outer_iter
		M = Q' * A * Q; 
		if iter > 1
			old_iter = curr_lambda;
		end

		[curr_lambda, curr_v] = local_power_iter_min(M);

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

		grad_q = A * (Q * curr_v) * curr_v';

		% Now we do the gradient ascent
		Q = Q + step_size * grad_q;

		Q = local_modified_GS(Q);

		if mod(iter, 100) == 0
			fprintf("Iteration %d : min R(x) = %f\n", iter, curr_lambda);
		end
	end

	M = Q' * A * Q;
	[curr_lambda, curr_v] = local_power_iter_min(M, 200);
	curr_v = Q * curr_v; % x = Py;
	curr_v = curr_v / norm(curr_v);
end





% Local function for getting the minimum eigenvalue of 
% a symmetric matrix
% we will first shift all eigenvalue to the negative side
% then we get the maximum eigenvalue, and then shift to the positive side

function [lambda, y] = local_power_iter_min(M, max_iter)

	if nargin < 2
		max_iter = 100;
	end

	m = size(M, 1);
	y = randn(m, 1);
	y = y / norm(y);
	% shift
	s = max(sum(abs(M), 2));
	M = M - s * eye(m);
	lambda_old = y' * M * y;

	for index = 1 : max_iter
		y = M * y;
		y = y / norm(y);
		lambda = y' * M * y;

		if abs(lambda - lambda_old) < 1e-6
			break;
		end

		lambda_old = lambda;
	end

	lambda = lambda + s;
end


% Local function for doing Gram-schmidt procedure
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
