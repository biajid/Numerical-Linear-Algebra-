function dNdt = popRate(t, N)
    % This function calculates the growth rate of two species; 
    % required parameters : time, and curr_pop_vector[first_lion, second_gazelle];
    bg = 1.1; bl = 0.00025;
    dg = 0.0005; dl = 0.7;

    f1 = bl * N(1) * N(2) - dl * N(1);
    f2 = bg * N(2) - dg * N(1) * N(2);

    dNdt = [f1; f2];
