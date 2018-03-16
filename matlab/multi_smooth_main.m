%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Multivariate Optimization with derivative

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
start_pt = [-53, -51]';
f_n = 3;
t_limit = 10;

%% 3 functions for contour plot
x = -5*abs(max(start_pt)):0.1:5*abs(max(start_pt));
y = -5*abs(max(start_pt)):0.1:5*abs(max(start_pt));
[X, Y] = meshgrid(x,y);  
Z1 = 2*X.^2+5*Y.^2;
Z2 = (1.5-X+X.*Y).^2 + (2.25-X+X.*(Y.^2))^2 + (2.625-X+X.*(Y.^3))^2;
Z3 = 100*(Y-X.^2)^2 + 3*(1-X).^2;
cont_set = {Z1, Z2, Z3};

%% Steepest Descent method
subplot(2,2,1);contour(X,Y,cont_set{f_n}, 10);
title(['Steepest Descent func',num2str(f_n)]);
[sol, t] = steepest_descent(f_set{f_n}, start_pt, t_limit);
x = sol(1);
y = sol(2);
fprintf('< Steepest Descent >\n');
fprintf('Solution point : (%f, %f)\n', x, y);
fprintf('Solution value : %f\n', eval(f_set{f_n}));
fprintf('Time spent : %fsec\n', t);

%% Newtons method
subplot(2,2,2);contour(X,Y,cont_set{f_n}, 10);
title(['Multi Newtons func',num2str(f_n)]);
[sol, t] = multi_newtons(f_set{f_n}, start_pt, t_limit);
x = sol(1);
y = sol(2);
fprintf('< Multi Newtons >\n');
fprintf('Solution point : (%f, %f)\n', x, y);
fprintf('Solution value : %f\n', eval(f_set{f_n}));
fprintf('Time spent : %fsec\n', t);

%% Quasi Newtons method (SR1)
subplot(2,2,3);contour(X,Y,cont_set{f_n}, 10);
title(['Quasi Newton (SR1) func',num2str(f_n)]);
[sol, t] = quasi_newton(f_set{f_n}, start_pt, t_limit, 'sr1');
x = sol(1);
y = sol(2);
fprintf('< Quasi Newton SR1 >\n');
fprintf('Solution point : (%f, %f)\n', x, y);
fprintf('Solution value : %f\n', eval(f_set{f_n}));
fprintf('Time spent : %fsec\n', t);

%% Quasi Newtons method (BFGS)
subplot(2,2,4);contour(X,Y,cont_set{f_n}, 10);
title(['Quasi Newton (BFGS) func',num2str(f_n)]);
[sol, t] = quasi_newton(f_set{f_n}, start_pt, t_limit, 'bfgs');
x = sol(1);
y = sol(2);
fprintf('< Quasi Newton BFGS >\n');
fprintf('Solution point : (%f, %f)\n', x, y);
fprintf('Solution value : %f\n', eval(f_set{f_n}));
fprintf('Time spent : %fsec\n', t);
