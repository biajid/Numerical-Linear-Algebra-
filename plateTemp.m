function plateTemp(T1, vol, area, temp_ambient)
    % This function calculate and plots the temperature of a metalic plate.
    % Function just plots a graph of T vs t, no output!
    % Required parameter: 
    % T1 -> Initial temperature;
    % vol -> volume of the plate
    % area -> surface area of the plate;
    % temp_ambient -> Ambient temperature;
    time_span = [0 180];
    [time, temp] = ode45(@dTdt, time_span, T1, [], vol, area, temp_ambient);
    plot(time, temp, 'r', 'LineWidth', 2);
    xlabel('Time in seconds');
    ylabel('Temperature in kelvin');
    title('Temperature Distribution in A metal surface over time.');
