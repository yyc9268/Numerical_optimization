%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Conjugate Gradient methods

clc;
clear all
base = [pwd, '\'];
addpath(genpath(base));

syms x y;
%% 3 functions
f = 2*x^2+5*y^2;
g = (1.5-x+x*y)^2 + (2.25-x+x*(y^2))^2 + (2.625-x+x*(y^3))^2;
h = 100*(y-x^2)^2 + 3*(1-x)^2;
f_set = {f, g, h};

%% Global setting
start_pt = [10 -8]';

%% 3 functions for contour plot
x = -5*abs(max(start_pt)):0.1:5*abs(max(start_pt));
y = -5*abs(max(start_pt)):0.1:5*abs(max(start_pt));
[X, Y] = meshgrid(x,y);  
Z1 = 2*X.^2+5*Y.^2;
Z2 = (1.5-X+X.*Y).^2 + (2.25-X+X.*(Y.^2))^2 + (2.625-X+X.*(Y.^3))^2;
Z3 = 100*(Y-X.^2)^2 + 3*(1-X).^2;
cont_set = {Z1, Z2, Z3};

for i = 1:length(f_set)
    %% Linear CG method
    subplot(3,2,2*i-1);contour(X,Y,cont_set{i}, 10);
    title(['Linear CG method func',num2str(i)]);
    [solution, t, iter] = linear_cg(f_set{i}, start_pt);
    fprintf('< Linear CG method >\n');
    x = solution(1);
    y = solution(2);
    fprintf('Point : (%f, %f), Solution : %f\n', x, y, (eval(f_set{i})));
    fprintf('Time : %f\n', t);
    fprintf('Iteration : %d\n', iter);
    %% Non-linear CG method
    subplot(3, 2 ,2*i);contour(X,Y,cont_set{i}, 10);
    title(['Non-linear CG method func',num2str(i)]);
    [solution, t, iter] = nonlinear_cg(f_set{i}, start_pt);
    fprintf('< Non-linear CG method >\n');
    x = solution(1);
    y = solution(2);
    fprintf('Point : (%f, %f), Solution : %f\n', x, y, (eval(f_set{i})));
    fprintf('Time : %f\n', t);
    fprintf('Iteration : %d\n', iter);
end
