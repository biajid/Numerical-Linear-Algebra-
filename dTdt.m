function y = dTdt(t, T, vol, surr_area, temp_amb)
    rho = 300; cv = 900; h = 30; epsilon = 0.8; sigma = 5.67e-8;
    term1 = -surr_area / (rho * cv * vol);
    term2 = sigma * epsilon;

    y = term1 .* (term2 .* (T .^ 4 - temp_amb .^ 4) + h .* (T - temp_amb));

end