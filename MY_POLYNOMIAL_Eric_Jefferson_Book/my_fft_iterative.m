function y = my_fft_iterative(x, forward)
	% This function performs iterative fft on 
	% the given signal/fourier_coef. 
	% Input x : signal/coef, and boolean forward 
	% true/false, true for forward transform, 
	% false for the reverse transform. 
	% default flag is true. 
	% Input length should be 2 ^ k, k = natural number.

	if nargin < 2
		forward = true;
	end

	n = length(x);

	y = fft_core_iterative(x, forward);

	if ~forward 
		y = y / n; % Normalizing for the inverse fft
	end

end

% Local function fft_core_iterative 
function y = fft_core_iterative(x, forward)
	n = length(x);

	%trivial case 
	if n == 1
		y = x;
		return;
	end

	% For forward set sign = -1, else sign = 1;
	if forward
		sign_factor = -1;
	else
		sign_factor = 1;
	end

	% step 1: doing bit reversal 
	bit_reversed_indices = get_bit_reversed_indices(n);
	% reverse x 
	y = x(bit_reversed_indices);

	% step 2: Bottom up butterfly stages
	num_stage = log2(n);
	
	for stage = 1 : num_stage
		m = 2 ^ stage; % This is the current block size
		half_m = m / 2;

		w_m = exp(sign_factor * 2 * pi * 1i / m);
		tau = w_m .^ (0 : half_m - 1);

		% looping over the block of size m 
		for k = 1 : m : n 
			u = y(k : k + half_m -1);
			v = tau .* y(k + half_m : k + m -1);

			% In place butterfly update 
			y(k : k + half_m - 1) = u + v;
			y(k + half_m : k + m - 1) = u - v;
		end 
	end 
end 


