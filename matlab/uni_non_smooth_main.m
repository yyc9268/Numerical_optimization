%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Optimization Homework
%% Fibonacci, Golden section search

clc;
clear all
base = [pwd, '\'];
addpath(genpath(base));

%% 5 functions
%f = @(x) x^2 + x;
%f = @(x) x^4 + x^3 + 1;
%f = @(x) 3*sin(x^2) + x^2 + x;
%f = @(x) exp(x^2) + x;
f = @(x) 5*sin(x^4) + 3*cos(x^3) + x;

%% Seeking bound algorithm
[a, b] = bound_seeking(f);
if f(a) == f(b)
    return;
end
fprintf('< Initial Boundary >\n');
fprintf('a = %f, b = %f\n\n', a, b);

%% Golden section search
[x_gol, t_gol, it_gol] = golden_section(f, a, b);
fprintf('< Golden Section >\n');
fprintf('solution : %f\n', x_gol);
fprintf('time : %f(ms)\n',t_gol*1000);
fprintf('iteration : %d\n\n', it_gol);

%% Fibonacci search for N = 10, 50, 100
N = [10, 40, 100];
fprintf('< Fibonacci Search >\n');
for i=1:length(N)
    [x_fib, interv, t_fib, it_fib] = fibonacci_search(f, a, b, N(i));
    fprintf('[N = %d]\n', N(i));
    fprintf('solution : %f\n', x_fib);
    fprintf('final interval : %f\n', interv);
    fprintf('time : %f(ms)\n', t_fib*1000);
    fprintf('iteration : %d\n', it_fib);
end