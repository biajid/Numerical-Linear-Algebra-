function out = norming(vec)
	%disp(vec);
	a = max(vec);
	%disp(a);
	vec = vec / a;
	%disp(vec);
	out = sqrt(sum(vec .^2)) * a;
end
