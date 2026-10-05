% DEMO_FFT_SINE Script to experiment with custom FFT on a sine wave

clear; clc; close all;

%% 1. Signal Parameters
Fs = 1000;              % Sampling frequency (1000 Hz)
T = 1 / Fs;             % Sampling period
N = 1024;               % Number of points (Must be a power of 2 for FFT)
t = (0 : N - 1) * T;    % Discrete time vector (1024 sample nodes)

f_signal = 50;          % Frequency of the sine wave (50 Hz)
A = 2;                  % Amplitude of the sine wave

% Generate discrete time-domain signal (Sampled points)
x = A * sin(2 * pi * f_signal * t);

%% 2. Compute Forward FFT using custom iterative function
% c contains the complex Fourier coefficients
c = my_fft_iterative(x, true);

%% 3. Prepare Frequency Axis & Magnitude Spectrum
magnitude_two_sided = abs(c) / N;
magnitude_one_sided = magnitude_two_sided(1 : N/2 + 1);
magnitude_one_sided(2 : end - 1) = 2 * magnitude_one_sided(2 : end - 1);

f_axis = (0 : N/2) * (Fs / N);

%% 4. Plotting Figure 1: Time Signal and Frequency Spectrum
figure(1);

% Top Plot: Original Discrete Time-Domain Signal
subplot(2, 1, 1);
plot(t * 1000, x, 'b-', 'LineWidth', 1.5);
grid on;
xlim([0, 100]); % View first 100 ms
xlabel('Time (ms)');
ylabel('Amplitude');
title('Original Sampled Signal: 50 Hz Sine Wave');

% Bottom Plot: FFT Frequency Spectrum
subplot(2, 1, 2);
stem(f_axis, magnitude_one_sided, 'r', 'LineWidth', 1.2, 'MarkerSize', 4);
grid on;
xlim([0, 150]); % View up to 150 Hz
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum (via my\_fft\_iterative)');

%% 5. Continuous Wave vs. Sampled Inverse FFT Reconstruction (Side-by-Side)
% Reconstruct signal back to time domain from Fourier coefficients
x_reconstructed = my_fft_iterative(c, false);

% Generate a dense "continuous" reference wave using linspace
t_continuous = linspace(0, (N - 1) * T, 5000); 
x_continuous = A * sin(2 * pi * f_signal * t_continuous);

% Plot comparison on figure(2) side-by-side
figure(2);

% Subplot 1 (1, 2, 1): Continuous Wave vs. Discrete Stem Nodes
subplot(1, 2, 1);
plot(t_continuous * 1000, x_continuous, 'b-', 'LineWidth', 1.5); 
hold on;
stem(t * 1000, x_reconstructed, 'r', 'LineWidth', 1.0, ...
     'Marker', 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'r'); 
hold off;
grid on;
xlim([0, 50]); % Zoom in on first 50 ms
xlabel('Time (ms)');
ylabel('Amplitude');
title('Continuous Wave vs. Discrete Stem Nodes');
legend('Continuous Analog Wave', 'Sampled IFFT Nodes', 'Location', 'northeast');

% Subplot 2 (1, 2, 2): Continuous Wave vs. Connected Sampled Line
subplot(1, 2, 2);
plot(t_continuous * 1000, x_continuous, 'b-', 'LineWidth', 1.5); 
hold on;
plot(t * 1000, x_reconstructed, 'r-o', 'LineWidth', 1.2, ...
     'MarkerSize', 4, 'MarkerFaceColor', 'r'); 
hold off;
grid on;
xlim([0, 50]); % Zoom in on first 50 ms
xlabel('Time (ms)');
ylabel('Amplitude');
title('Continuous Wave vs. Joined Sampled Points');
legend('Continuous Analog Wave', 'Joined IFFT Line', 'Location', 'northeast');

% Display numeric error in terminal
reconstruction_error = norm(x - x_reconstructed);
fprintf('Reconstruction error norm(x - x_reconstructed): %.4e\n', reconstruction_error);