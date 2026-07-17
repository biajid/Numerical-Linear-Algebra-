% -------------------------------------------------------------------------
% Example 3-4 : Solution of an Equation with Multiple Roots
%
% The natural frequencies of free vibration of a cantilever beam are
% determined from the roots of the nonlinear equation
%
%       f(x) = cos(x) * cosh(x) + 1 = 0
%
% where
%
%       x = k_n * L
%
% L   : Length of the beam
% k_n : Wave number corresponding to the nth vibration mode
%
% Once a root x = k_n L is obtained, the corresponding natural frequency is
%
%                      __________
%            2        / EI
%   w_n = (k_n L) *  / --------
%                   \/ rho*A*L^4
%
% where
%
%   E   : Elastic modulus of the beam
%   I   : Area moment of inertia
%   A   : Cross-sectional area
%   rho : Density of the beam material
%
% -------------------------------------------------------------------------
% Objectives
%
% (a) Determine the first root of
%
%         cos(x) * cosh(x) + 1 = 0
%
%     by first locating a small interval containing the root and then
%     applying the Secant Method.
%
% (b) Write a MATLAB program that computes the values of x = k_n L
%     corresponding to the first four roots of the equation.
%
% -------------------------------------------------------------------------
% In this program, only the nonlinear equation
%
%         cos(x) * cosh(x) + 1 = 0
%
% is solved numerically. Once the roots are known, they can be substituted
% into the natural-frequency formula above to obtain the vibration
% frequencies of the cantilever beam.
% -------------------------------------------------------------------------

clc;
close all;
clear;

f = @(x) cos(x) .* cosh(x) + 1;
increment = 0.2;
boundary = 11.2;

index = 1;
start = 0;
stop = start + increment;

while stop <= boundary
    if f(start) * f(stop) < 0
        Roots(index) = fzero(f, [start, stop]);
        index = index + 1;
    end
    start = stop;
    stop = stop + increment;
end
Roots
