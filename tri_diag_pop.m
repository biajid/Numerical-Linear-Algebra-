n = 3;
for i = 1 : 1 : 3
	for j = 1 : 3
		if (i == j)
			D(i, j) = 4;
			E(i, j) = 5;
		elseif abs(i - j) == 1
			D(i, j) = -1;
			if(i > j) E(i, j) = -1; % -1 on subdiagonal;
			else
				E(i, j) = 1; % +1 on the superdiagonal
			end
		else 
			D(i, j) = 0;
			E(i, j) = 0;
		end
	end
end

disp("D matrix is given below");
disp(D);
disp("E matrix is given below");
disp(E);

