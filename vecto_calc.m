function vecto_calc(flag, N)
	if (nargin < 2)
		N = 1000000;
	end
	x = linspace(1, 1, N);

	tic;

	if (flag)
		x = sqrt(x);
		elapsed = toc;
	end

	if (~flag)
		for i = 1 : N 
			x(i) = sqrt(x(i));
		end
		elapsed = toc;
	end


	fprintf("Cpu usage time is %g s\n", elapsed);
end

