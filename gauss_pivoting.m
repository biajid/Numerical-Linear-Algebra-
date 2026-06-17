function x = gauss_pivoting(A, b)
	[m, n] = size(A);
	if m ~= n 
		error('Matrix is not square!');
	end

	if (length(b) ~= n)
		error('Size of b does not match with A');
	end

	Aug = [A, b(:)];

	% Now traverse rows, and look for pivot
	for i = 1 : n - 1
		[max_val, max_index] = max(abs(Aug(i : end, i)));
		max_index = max_index + i - 1;

		if max_index ~= i 
			temp = Aug(i, :);
			Aug(i, :) = Aug(max_index, :);
			Aug(max_index, :) = temp;
		end

		% Now do the elemination 
		for r = (1 + i) : n
			multiplier = Aug(r, i) / Aug(i, i);
			Aug(r, i : end) = Aug(r, i : end) - multiplier * Aug(i, i : end);
		end
	end

	% Now do the back substitution

	x = zeros(n, 1);

	if (abs(Aug(n, n)) < 1e-12)
		error('Divison by zero!');
	end

	x(n) = Aug(n, end) / Aug(n, n);

	for i = n - 1 : -1 : 1
		acc = Aug(i , i + 1 : n) * x(i + 1 : end);
		x(i) = (Aug(i, end) - acc) / Aug(i, i);
	end
end

 

			

