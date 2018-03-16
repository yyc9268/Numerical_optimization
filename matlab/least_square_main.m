%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Gauss-Newton and Levenberg-Marquardt

clc;
clear all
base = [pwd, '\'];
addpath(genpath(base));

data = xlsread('observation_data_LSM_LM_2017.xlsx');

syms a b c d x y z;
%% 2 functions

f = a*x + b*y + c*z + d;
g = exp(-((x-a)^2 + (y-b)^2 + (z-c)^2)/d^2);

func = g;
%{
[a, b, c, d, soq, t, iter] = gauss_newton(func, data);
fprintf('<Gauss newton method>\n');
fprintf('a : %f, b : %f, c : %f, d : %f\n',a,b,c,d);
fprintf('Sum of square : %f\n', soq);
fprintf('Time : %f, Iter : %f\n\n', t, iter);
%}
[a, b, c, d, soq, t, iter] = l_m(func, data);
fprintf('<Levenberg-Marquardt method>\n');
fprintf('a : %f, b : %f, c : %f, d : %f\n',a,b,c,d);
fprintf('Sum of square : %f\n', soq);
fprintf('Time : %f, Iter : %f\n', t, iter);
