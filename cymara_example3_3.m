%{
Example 3: In this example we will see how to write a for loop that will calculate
the following sum:
(1 + 1/2)(1 + 1/4)(1 + 1/6)(1 + 1/8)(1 + 1/10) . . . (1 + 1/100).
%}

s = 1;
for term = 1 : 50
	s = s * (1 + 1 / (2 * term));
end

fprintf("The product of the terms is: %g\n", s);

