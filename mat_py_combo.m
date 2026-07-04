disp('Hello, World!');
% Let us check whether Matlab can recognize the python environment
% Help me how to load python environment in matlab
%pyenv


% Let us try to use python in matlab
py.math.sqrt(100)
% So we have seen that it is working 
% Let us try to import numpy as np
py.importlib.import_module('numpy'); 
% Create an alias for numpy
np = py.importlib.import_module('numpy');
% Now we can use numpy functions
a = np.array([1, 2, 3]);
disp(a);
disp(np.sum(a));

% Let us now try to import matplotlib.pyplot as plt
plt = py.importlib.import_module('matplotlib.pyplot');
% Now we can use matplotlib functions


% I am getting this error : Error using function_base>linspace (line 123)
%Python Error: TypeError: 'float' object cannot be interpreted as an integer
% This error occurs because the linspace function expects the third argument to be an integer, but it is receiving a float. To fix this issue, you can convert the third argument to an integer using the int() function. Here is how you can modify the code:
% How to explicitly say a as int in matlab
a = int32(100); % Convert the third argument to an integer
%a = int(100); % Convert the third argument to an integer

x = np.linspace(0, 10, a); % Convert the third argument to an integer
y = np.sin(x);
plt.plot(x, y, 'r-');
plt.show();

% Matplotlib is not working; it is saying frozen import lib gcd_importer. This is a common issue when using matplotlib in a frozen application.
% To fix this issue, you can try the following steps:
% 1. Make sure you have the latest version of matplotlib installed.
% 2. Try to import matplotlib in a regular Python environment to see if it works there.
% 3. If it works in a regular Python environment, you may need to set the MPLCONFIGDIR environment variable to a writable directory before importing matplotlib in Matlab. You can do this by adding the following line before importing matplotlib:
%    setenv('MPLCONFIGDIR', tempdir);
% 4. If the issue persists, you may need to check if there are any conflicting versions of Python or matplotlib installed on your system and ensure that Matlab is using the correct Python environment.

% Yeah now it is working 
% But how to work with .mlx files in vs code
% To work with .mlx files in Visual Studio Code, you can follow these steps:
% 1. Install the "Matlab" extension for Visual Studio Code from the Extensions marketplace.
% 2. Open your .mlx file in Visual Studio Code.
% 3. The Matlab extension should automatically recognize the .mlx file and provide syntax highlighting and other features for Matlab code.
% 4. You can run the Matlab code in the .mlx
% Well, it is working, but how to switch between text and code in .mlx files in vs code
% In Visual Studio Code, you can switch between text and code in .mlx files by using the "Matlab" extension's features. Here are the steps to do that:
% 1 . Open your .mlx file in Visual Studio Code.
% 2. The Matlab extension should automatically recognize the .mlx file and provide a toolbar at
% the top of the editor.
% 3. In the toolbar, you will see options to switch between "Code" and "Text" modes.
% 4. Click on the "Code" button to switch to code mode, where you can write and execute Matlab code.
% 5. Click on the "Text" button to switch to text mode, where you can write and format text using Markdown or other formatting options.
% 6. You can also use keyboard shortcuts to switch between modes. For example, you can use "Ctrl + Shift + C" to switch to code mode and "Ctrl + Shift + T" to switch to text mode.
% 7. Make sure to save your changes after switching between modes to ensure that your code and text are properly saved in the .mlx file.    
% okay I am now using .m and its fine for now
hw = py.textwrap.wrap('Hello, World!', width = int32(2));
disp(hw);
disp(hw(1));
disp(hw(2));
mod = py.importlib.import_module('weather_script');
weatherData = mod.get_weather('New York');

disp(weatherData)
disp(double(weatherData{'temperature'}))
disp(double(weatherData{'humidity'}))