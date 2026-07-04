for numspins = [100, 1000000000]
    for i = 1 : 3
        result = playRoulette(numspins, 2, 1);
        fprintf('%d spins-> Expected Return betting 2 = %.4f%%\n', ...
            numspins, 100 * result)
    end
end
