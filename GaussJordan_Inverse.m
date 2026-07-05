function A_inv = GaussJordan_Inverse(A)
[r, c] = size(A);
dummy = c;
if r ~= c 
    error("Matrix is not square!");
end

Ab = [A, eye(r)];
[r, c] = size(Ab);

for i = 1 : r - 1
    for j = i + 1 : r 
        Ab(j, i : end) = Ab(j, i : end) - (Ab(j, i) / Ab(i, i)) * Ab(i, i : end);
    end
end


for i = r : -1 : 1
    Ab(i, :) = Ab(i, :) / Ab(i, i);
    for j = i - 1 : -1 : 1
        term = Ab(j, i);
        Ab(j, i : end) = Ab(j, i : end) - term * Ab(i, i : end);
    end
end

A_inv = Ab(:, dummy + 1 : end);




end

    

        