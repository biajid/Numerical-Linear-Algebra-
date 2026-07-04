% z =x.^2 + y.^2 on [-5  5];
clc;
clear all; close all;

x =  linspace(-5, 5);

y = linspace(-5, 5);
[x, y] = meshgrid(x, y);
z = x.^2 + y.^2;

surf(x, y, z);


