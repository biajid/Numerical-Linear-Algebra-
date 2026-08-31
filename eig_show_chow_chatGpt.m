function eig_show_chow_chatGpt(A)
%EIG_SHOW_CHOW_CHATGPT
% Modern interactive visualization of eigenvectors and singular vectors
% for real 2-by-2 matrices.
%
% Inspired by the classical EIGSHOW demonstration associated with
% Gilbert Strang's linear algebra teaching.
%
% -------------------------------------------------------------------------
% EIGENVALUE MODE
% -------------------------------------------------------------------------
% Move the vector x around the unit circle.
%
% We compare
%
%                       x   and   A*x.
%
% If A*x is parallel or antiparallel to x, then
%
%                       A*x = lambda*x,
%
% so x is an eigenvector and lambda is the corresponding eigenvalue.
%
% -------------------------------------------------------------------------
% SVD MODE
% -------------------------------------------------------------------------
% We use two perpendicular unit vectors
%
%                       x  and  y.
%
% Move x around the unit circle.  The vector y remains perpendicular to x.
% We then examine
%
%                       A*x  and  A*y.
%
% When A*x and A*y are perpendicular, x and y are right singular vectors.
% Their image lengths are the corresponding singular values.
%
% -------------------------------------------------------------------------
% USAGE
% -------------------------------------------------------------------------
%
%   eig_show_chow_chatGpt
%
% or
%
%   A = [2 1; 1 2];
%   eig_show_chow_chatGpt(A)
%
% -------------------------------------------------------------------------

    if nargin < 1
        A = [1 3; 2 4] / 4;
    end

    validateattributes(A, {'numeric'}, ...
        {'real','finite','size',[2 2]}, ...
        mfilename, 'A');

    A = double(A);

    % Some useful teaching examples.
    examples = {
        'Diagonal: [5/4 0; 0 3/4]',          [5/4 0; 0 3/4]
        'Negative eigenvalue',               [5/4 0; 0 -3/4]
        'Identity',                          eye(2)
        'Reflection',                        [0 1; 1 0]
        '90 degree rotation',                [0 1; -1 0]
        'General matrix 1',                  [1 3; 4 2]/4
        'General matrix 2',                  [1 3; 2 4]/4
        'General matrix 3',                  [3 1; 4 2]/4
        'Complex eigenvalues',               [3 1; -2 4]/4
        'Rank one',                          [2 4; 2 4]/4
        'Singular nilpotent',                [2 4; -1 -2]/4
        'Repeated eigenvalue / Jordan',      [1 0; -1 1]
        'User matrix',                       A
    };

    % ---------------------------------------------------------------------
    % Figure and axes
    % ---------------------------------------------------------------------

    fig = figure( ...
        'Name', 'Eigenvalue / SVD Explorer', ...
        'NumberTitle', 'off', ...
        'Color', 'w', ...
        'MenuBar', 'none', ...
        'ToolBar', 'figure');

    ax = axes( ...
        'Parent', fig, ...
        'Position', [0.08 0.12 0.62 0.78]);

    hold(ax, 'on');
    axis(ax, 'equal');
    grid(ax, 'on');
    box(ax, 'on');

    xlabel(ax, 'x_1');
    ylabel(ax, 'x_2');

    % ---------------------------------------------------------------------
    % Controls
    % ---------------------------------------------------------------------

    uicontrol(fig, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position', [0.73 0.91 0.24 0.04], ...
        'String', 'Matrix example', ...
        'FontWeight', 'bold', ...
        'BackgroundColor', 'w');

    popup = uicontrol(fig, ...
        'Style', 'popupmenu', ...
        'Units', 'normalized', ...
        'Position', [0.73 0.86 0.24 0.05], ...
        'String', examples(:,1), ...
        'Value', size(examples,1), ...
        'Callback', @changeMatrix);

    modeButton = uicontrol(fig, ...
        'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [0.73 0.77 0.24 0.06], ...
        'String', 'Switch to SVD mode', ...
        'Callback', @switchMode);

    resetButton = uicontrol(fig, ...
        'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [0.73 0.69 0.24 0.06], ...
        'String', 'Reset x', ...
        'Callback', @resetVector);

    infoText = uicontrol(fig, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position', [0.72 0.18 0.26 0.46], ...
        'BackgroundColor', 'w', ...
        'HorizontalAlignment', 'left', ...
        'FontName', 'FixedWidth', ...
        'FontSize', 10);

    instructionText = uicontrol(fig, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position', [0.72 0.05 0.26 0.10], ...
        'BackgroundColor', 'w', ...
        'HorizontalAlignment', 'left', ...
        'FontWeight', 'bold');

    % ---------------------------------------------------------------------
    % Store application data
    % ---------------------------------------------------------------------

    data.A = A;
    data.examples = examples;
    data.mode = "eig";
    data.x = [1;0];

    data.ax = ax;
    data.popup = popup;
    data.modeButton = modeButton;
    data.infoText = infoText;
    data.instructionText = instructionText;

    guidata(fig, data);

    % Mouse interaction.
    fig.WindowButtonDownFcn   = @mouseAction;
    fig.WindowButtonMotionFcn = @mouseMove;

    redraw();


    % =====================================================================
    % NESTED CALLBACK FUNCTIONS
    % =====================================================================

    function mouseAction(~,~)

        if ~isvalid(fig)
            return
        end

        updateFromMouse();

    end


    function mouseMove(~,~)

        % Update only while the left mouse button is pressed.
        if ~strcmp(fig.SelectionType, 'normal')
            return
        end

        updateFromMouse();

    end


    function updateFromMouse()

        data = guidata(fig);

        cp = data.ax.CurrentPoint;
        p = cp(1,1:2)';

        r = norm(p);

        if r < 1e-12
            return
        end

        % Project mouse position onto unit circle.
        data.x = p / r;

        guidata(fig, data);

        redraw();

    end


    function switchMode(~,~)

        data = guidata(fig);

        if data.mode == "eig"
            data.mode = "svd";
            data.modeButton.String = 'Switch to eigenvalue mode';
        else
            data.mode = "eig";
            data.modeButton.String = 'Switch to SVD mode';
        end

        guidata(fig, data);

        redraw();

    end


    function resetVector(~,~)

        data = guidata(fig);
        data.x = [1;0];

        guidata(fig, data);

        redraw();

    end


    function changeMatrix(src,~)

        data = guidata(fig);

        index = src.Value;

        data.A = data.examples{index,2};
        data.x = [1;0];

        guidata(fig, data);

        redraw();

    end


    % =====================================================================
    % DRAW EVERYTHING
    % =====================================================================

    function redraw()

        data = guidata(fig);

        A = data.A;
        x = data.x;

        cla(data.ax);
        hold(data.ax, 'on');
        grid(data.ax, 'on');
        box(data.ax, 'on');
        axis(data.ax, 'equal');

        % Unit circle
        theta = linspace(0, 2*pi, 500);

        plot(data.ax, ...
            cos(theta), sin(theta), ...
            'k:', ...
            'LineWidth', 1.2);

        Ax = A*x;

        % Choose axis limits large enough to display A*x.
        scale = max([1.4, 1.25*norm(A,2), 1.25*norm(Ax)]);

        xlim(data.ax, [-scale scale]);
        ylim(data.ax, [-scale scale]);

        xlabel(data.ax, 'x_1');
        ylabel(data.ax, 'x_2');

        if data.mode == "eig"

            drawVector(data.ax, x,  ...
                [0.10 0.55 0.10], 'x');

            drawVector(data.ax, Ax, ...
                [0.10 0.25 0.85], 'Ax');

            % -------------------------------------------------------------
            % Measure how parallel x and Ax are.
            %
            % det([x Ax]) = 0  <=>  x and Ax are parallel.
            % -------------------------------------------------------------

            parallelError = abs(det([x Ax]));

            % Since ||x|| = 1,
            %
            % x'*A*x
            %
            % equals lambda exactly when x is an eigenvector.
            lambdaEstimate = x' * Ax;

            [V,D] = eig(A);
            eigenvalues = diag(D);

            title(data.ax, ...
                sprintf('Eigenvalue mode: move x until Ax is parallel to x'));

            if parallelError < 1e-2

                status = '*** EIGENVECTOR FOUND ***';

            else

                status = 'Move x until Ax || x';

            end

            data.infoText.String = sprintf([ ...
                'A =\n' ...
                '  %8.4f  %8.4f\n' ...
                '  %8.4f  %8.4f\n\n' ...
                'x =\n' ...
                '  %8.4f\n' ...
                '  %8.4f\n\n' ...
                'Ax =\n' ...
                '  %8.4f\n' ...
                '  %8.4f\n\n' ...
                'lambda estimate:\n' ...
                '  %8.4f\n\n' ...
                'parallel error:\n' ...
                '  %.3e\n\n' ...
                'eig(A):\n' ...
                '  %s\n' ...
                '  %s\n\n' ...
                '%s'], ...
                A(1,1), A(1,2), ...
                A(2,1), A(2,2), ...
                x(1), x(2), ...
                Ax(1), Ax(2), ...
                lambdaEstimate, ...
                parallelError, ...
                num2str(eigenvalues(1), '%.4g'), ...
                num2str(eigenvalues(2), '%.4g'), ...
                status);

            data.instructionText.String = sprintf([ ...
                'Goal:\n' ...
                'Find x such that\n' ...
                'Ax = lambda x']);

        else

            % -------------------------------------------------------------
            % SVD MODE
            % -------------------------------------------------------------

            y = [-x(2); x(1)];

            Ay = A*y;

            drawVector(data.ax, x, ...
                [0.10 0.55 0.10], 'x');

            drawVector(data.ax, y, ...
                [0.10 0.55 0.10], 'y');

            drawVector(data.ax, Ax, ...
                [0.10 0.25 0.85], 'Ax');

            drawVector(data.ax, Ay, ...
                [0.75 0.20 0.20], 'Ay');

            % Orthogonality test:
            %
            % Ax perpendicular to Ay  <=>  (Ax)'*(Ay) = 0.
            orthogonalityError = abs(Ax' * Ay);

            sx = norm(Ax);
            sy = norm(Ay);

            singularValues = svd(A);

            title(data.ax, ...
                'SVD mode: move x until Ax is perpendicular to Ay');

            if orthogonalityError < 1e-2

                status = '*** SINGULAR DIRECTIONS FOUND ***';

            else

                status = 'Move until Ax perpendicular Ay';

            end

            data.infoText.String = sprintf([ ...
                'A =\n' ...
                '  %8.4f  %8.4f\n' ...
                '  %8.4f  %8.4f\n\n' ...
                '||Ax|| = %8.4f\n' ...
                '||Ay|| = %8.4f\n\n' ...
                '(Ax)^T(Ay) =\n' ...
                '  %.3e\n\n' ...
                'svd(A):\n' ...
                '  %8.4f\n' ...
                '  %8.4f\n\n' ...
                '%s'], ...
                A(1,1), A(1,2), ...
                A(2,1), A(2,2), ...
                sx, sy, ...
                Ax'*Ay, ...
                singularValues(1), ...
                singularValues(2), ...
                status);

            data.instructionText.String = sprintf([ ...
                'Goal:\n' ...
                'Find x,y such that\n' ...
                'Ax is perpendicular to Ay']);

        end

        guidata(fig, data);

    end


    % =====================================================================
    % VECTOR DRAWING HELPER
    % =====================================================================

    function drawVector(axHandle, v, color, label)

        quiver(axHandle, ...
            0, 0, v(1), v(2), 0, ...
            'Color', color, ...
            'LineWidth', 2.2, ...
            'MaxHeadSize', 0.15);

        plot(axHandle, ...
            v(1), v(2), ...
            '.', ...
            'Color', color, ...
            'MarkerSize', 20);

        text(axHandle, ...
            0.55*v(1), ...
            0.55*v(2), ...
            ['  ' label], ...
            'Color', color, ...
            'FontSize', 12, ...
            'FontWeight', 'bold');

    end

end
