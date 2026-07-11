function [vect, out] = qr_method(A)
	A0 = A;
	[Q, R] = qr(A);
	A1 = R * Q;
	n = 1;
	[m, ~] = size(A);
	

	while ~check_ut(A1)
		A = A1;
		[Q, R] = qr(A);
		A1 = R * Q;
		n = n + 1;
		

		if n > 100 * m 
			error('Method failed!');
		end

	end
	raw_ev = diag(A1);
	[out, idx] = sort(raw_ev, 'descend');
	vect = zeros(m, m);

	for i = 1 : m 
		vect(:, i) = (A0 - (out(i) + 1e-12) * eye(m)) \ rand(m, 1);
		vect(:, i) = vect(:, i) / norm(vect(:, i));
	end

	out = diag(out);


end