function rev_map = get_bit_reversed_indices(n) 
	% This function does perform bit reversing 
	% on the index n of an array 
	% n must be of 2 ^ k, where k is in N. 
	% It is similar to Matlab's bitrevorder

	num_bits = log2(n);
	rev_map = zeros(1, n);

	for index = 0 : n - 1

		value = index;
		reversed = 0;

		for bit = 1 : num_bits
			last_bit = mod(value , 2);
			reversed = 2 * reversed + last_bit;
			value = floor(value / 2);
		end

		% Matlab uses 1 based index;
		% so we will shift each binary bit by 1
		rev_map(index + 1) = reversed + 1;
	end
end
