function [m s] = statistics(x)
	n = length(x);
	m = avg(x, n);
    temp1 = sum((x - m) .^ 2);
    temp2 = temp1 / (n - 1);
    s = sqrt(temp2);
end

function m = avg(x, n)
    m = sum(x) / n;
end
 



    
    

