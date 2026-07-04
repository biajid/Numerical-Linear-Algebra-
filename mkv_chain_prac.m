function out = mkv_chain_prac(P)
	out = P;
	current = P;
	while true
		old = current;
		current = old * P;
		if norm(current - old) <= eps
			out = current;
			break;
		end
	end


