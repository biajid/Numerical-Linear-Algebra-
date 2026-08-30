% How many times to roll a die to get a 3
a = 3;
b = randi(6);
c = 1;
Counter = zeros(1, 100000);
for ii = 1 : length(Counter)
    while b ~= a 
        b = randi(6);
        c = c + 1;
    end


    %disp(['Total count : ', num2str(c)]);
    Counter(ii) = c;
    c = 1;
    b = randi(6);
end

disp(['Average count: ', num2str(round(mean(Counter)))]);

bar(histcounts(Counter, 1 : 50));