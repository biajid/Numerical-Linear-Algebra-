%{
This example is from Amos Gilat's Numerical analysis, chapter 4, example 6.
Here we will apply Kirchoff's laws to get current's in a circuit, using 
linear system of equation. 
Rules for the convention: 
In a closed loop, moving from -ve terminal of the battery +ve, we will put
voltage as positive.
In a closed loop, if we pass resistor in the current direction, then
voltage drop is negative. However if the current passes in our opposite
direction, then voltage drop is positive. 
I follow this convention as it alligns with physics well : The voltage
gives energy while current in resistor burns those energy. 
Opposite current gives an impression of opposing loss of energy!
%}

%{
    Here we have four loop; so we would have 4*4 system, with four current.
    Loop1: 
    24 - 3 * i1 - 2(i1 - i3) - 4(i1 - i2) = 0;
    or, 24 = 3 * i1 + 2 * i1 - 2 * i3 + 4 * i1 - 4 * i2;
    or 9 * i1 - 4 * i2 - 2 * i3 + 0 * i4 = 24;

    Loop2: 
    -16 - 4(i2 - i1) - 6(i2 - i3) - 3(i2 - i4) - 4*i2 = 0;
    4 * i1 - 17 * i2 + 6 * i3 + 3 * i4 = 16;

    Loop3:
    -2 * (i3 - i1) - 6 * (i3 - i4) - 6 * (i3 - i2) = 0;
    2 * i1 + 6 * i2 - 14 * i3 + 6 * i4 = 0;
    
    Loop4: 
    18 - 2 * i4 - 3 * (i4 - i2) - 6 * (i4 - i3) = 0;
    18 = 11 * i4 + 3 * i2 - 6 * i3; 
    0 * i1 - 3 * i2 - 6 * i3 + 11 * i4 = 18;

    Now we will solve this system, using our own function. 

    

%}

A = [9 -4 -2 0;
    4 -17 6 3;
    2 6 -14 6;
    0 -3 -6 11];
b = [24; 16; 0; 18];

x = LUSolve(A, b);
disp(['Solution from our function: ']);
x

y = A \ b;
disp(['Solution from Matlab: ']);
y