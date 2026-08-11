x = -1 : 0.01 : 1;
y = -1 : 0.01 : 1;
[X, Y] = meshgrid(x, y);
Z = sin(pi .* X) .* cos(pi .* Y);
surf(X, Y, Z);
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');  
hold on; 


% Now we will parameterize the surface, and then use the Bezier-DeCasteljau algorithm to evaluate the surface at given points.
% First step is to take some sample points in the parameter space. 
t = linspace(0, 1, 30); % this are sample points for the surface.
[xt, yt] = meshgrid(t, t);
zt = sin(pi .* xt) .* cos(pi .* yt);
% Now we have to think wisely.
% For each point in xt, we will get yt from 0 to 1. 

F = zeros(size(zt)); % This will hold the evaluated points on the surface at each t.
for i1 = 1 : length(t)  
    % For each fixed point of xt, we will get the corresponding yt and zt.
    % So we will take the corresponding points in the parameter space, and then evaluate the surface at that point using the Bezier-DeCasteljau algorithm.
    P = [t(:)', t(i1), zt(i1, :)']; % This is the control points for the surface at fixed xt(i1, :).
    F(i1, :) = Bezier_CastelJau_Curve(P, t); % This will give us the evaluated points on the surface at fixed xt(i1, :).
end

% Now we have to shift the evaluated points to the original parameter space.
% We will now plot the evaluated surface along with the original surface.
