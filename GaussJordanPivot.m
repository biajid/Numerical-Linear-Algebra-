function x = GaussJordanPivot(A, b)
[r, c] = size(A);
if r ~= c 
    error("Matrix is not square!");
end
x = zeros(r, 1);
Ab = [A, b];
[r, c] = size(Ab);

for i = 1 : r - 1
    pivot = Ab(i, i);
    
    % Now I want to look for the maximum pivot element and swap row i with 
    % that maximum pivot carrying row
    %{
    [~, maxIndex] = max(abs(Ab(i:r, i)));
    maxIndex = maxIndex + i - 1; % Adjust index to the original matrix
    if maxIndex ~= i
        Ab([i, maxIndex], :) = Ab([maxIndex, i], :); % Swap rows
    end
    %}
    [~, maxIndex] = max(abs(Ab(i : end, i)));
    maxIndex = maxIndex + i - 1;

    if maxIndex ~= i
        Ab([i, maxIndex], :) = Ab([maxIndex, i], :);
    end

    % Now perform the Gauss Elimination

    for j = i + 1 : r 
        Ab(j, i : end) = Ab(j, i : end) - (Ab(j, i) / Ab(i, i)) * Ab(i, i : end);
    end

end
%{
% Now do the back substitution to get the solution 
x(end) = Ab(r, c) / Ab(r, c - 1);

for i = r - 1 : -1 : 1
    x(i) = Ab(i, end) - Ab(i, i + 1 : end - 1) * x(i + 1 : end);
    x(i) = x(i) / Ab(i, i);
end
%}

% Now I will do rref or Jordan form

for i = r : -1 : 1
    Ab(i, :) = Ab(i, :) / Ab(i, i);
    for j = i - 1 : -1 : 1
        term = Ab(j, i);
        Ab(j, i : end) = Ab(j, i : end) - term * Ab(i, i : end);
    end
end

x = Ab(: , end);
x = x(:);




end

    

        