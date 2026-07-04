function z = nr_mul_root(xinitial)
    disp("Hello from nr_mul_root");

    %a = xinitial;
    %clear;
    clc;
    close all;
    
    xplot = linspace(-15, 30, 1000);
    yplot = f(xplot);
    
    
    %plot(xplot, yplot, "Color",'red','LineStyle','-','LineWidth',2);
    
    %z = NR(a);
    %xlabel('x-axis');
    %ylabel('y-axis');
    %title('Plot of the Function f(x)');
    %hold on;
    grid on;
    xguesses = -50 : 1 : 50;
    z = [];

    for a = xguesses
        %disp(['starting with initial guess =', num2str(a)])
        z = [z; NR(a)];
        %disp(['Solution is : ', num2str(z)]);
        %pause(1);
    end
    disp(['Unique Solutions are : ']);
    z = unique(z');
    disp(z');
    %hold off;
    %xlabel('x-axis');
    %ylabel('y-axis');
    
    %title('Plot of the Function f(x)');
    
    function y = f(x)
        y = (x - 10) .* (x + 10) .* (x - 20);
    end

    function yprime = fprime(x)
        %yprme = (3*x.^2 - 100); % Derivative of f(x)
        dx = 0.01;
        yprime = (f(x + dx) - f(x - dx)) / (2 .* dx);
    end
    
    function sol = NR(xinitial)
        iters = 1;
        err = abs(f(xinitial));
        x_iter = xinitial;

        while(iters < 1000) && (err > 1e-4)
            %plot(x_iter, f(x_iter), Marker="*", MarkerSize=20, MarkerFaceColor="black");

            x_iter = x_iter - f(x_iter) / fprime(x_iter);
            iters = iters + 1;
            err = abs(f(x_iter));
        end
        sol = x_iter;
    end


    
end
