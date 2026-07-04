function avgReturn = playRoulette(numSpins, pocket, bet)
    pockets = 1 : 36;
    pocketOdds = 35;
    totalProfit = 0;

    for i = 1 : numSpins
        ball = pockets(randi(36)); %random spin

        if ball == pocket
            totalProfit = totalProfit + bet * pocketOdds; % Win scenario
        else
            totalProfit = totalProfit - bet;
        end
    end

    avgReturn = totalProfit / numSpins;
end

