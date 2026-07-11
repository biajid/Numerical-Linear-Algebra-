function out = check_ut(A)
	[m, n] = size(A);

	out = true;
	for i = 1 : m - 1
		if any(abs(A(i + 1 : end, i)) > 1e-9)
			out = false;
			break;
		end
	end

	
end

