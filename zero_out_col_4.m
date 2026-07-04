x = [1, 2, 3, 4]';

% Here our target is to zero out the column 4,
% while keeping the length of the vector 
% intact, and only utilizing the row 2.

% So we need a rotation matrix of the form 
%{ 
	G = [1 0 0 0;
		0 c 0 s;
		0 0 1 0;
		0 -s 0 c];
		% Moral of the story, the one that 
		gonna get vanish should have negative first!

%}

value_len = sqrt(x(2)^2 + x(4)^2);
c = x(2) / value_len;
s = x(4) / value_len;

G = [1 0 0 0;
	0 c 0 s;
	0 0 1 0;
	0 -s 0 c];

y1 = G * x;

disp(['Rotated vector is : ', mat2str(y1)]);
disp(y1);


%{
	Now I am trying to remove 1st element of the vector and shift the weight to the third element.
%}
vl = sqrt(x(1) ^ 2 + x(3) ^ 2);
c = x(3) / vl;
s = x(1) / vl;

G = [ c 0 -s 0;
	  0 1 0 0;
	  s 0 c 0;
	  0 0 0 1];


y1
y2 = G * x

% Now I will remove col 4 and shift it's weight to the third element. 
vl = sqrt(x(3) ^ 2 + x(4) ^ 2);
c = x(3) / vl;
s = x(4) / vl;

G = [
	1 0 0 0;
	0 1 0 0;
	0 0 c s;
	0 0 -s c;
];

y4 = G * x
