%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Multivariate Optimization
%% Nelder-Mead, Powell's method

%% 3 functions
f1 = @(x, y) 2*x^2+5*y^2;
f2 = @(x, y) (1.5-x+x*y)^2 + (2.25-x+x*(y^2))^2 + (2.625-x+x*(y^3))^2;
f3 = @(x, y) 100*(y-x^2)^2 + 3*(1-x)^2;
f_set = {f1, f2, f3};
%% 3 functions for contour plot
x = -250:0.1:250;
y = -250:0.1:250;
[X, Y] = meshgrid(x,y);  
Z1 = 2*X.^2+5*Y.^2;
Z2 = (1.5-X+X.*Y).^2 + (2.25-X+X.*(Y.^2))^2 + (2.625-X+X.*(Y.^3))^2;
Z3 = 100*(Y-X.^2)^2 + 3*(1-X).^2;
cont_set = {Z1, Z2, Z3};

for i = 1:length(f_set)
    fprintf('Function(%d) : ', i);
    disp(f_set{i});
    %% Nelder and Mead algorithm
    subplot(2,3,i);contour(X,Y,cont_set{i}, 10);
    title(['nelder&mead func',num2str(i)]);
    [sol,t_sol,iter] = nelder_mead(f_set{i});
    fprintf('< Nelder&Mead >\n');
    fprintf('solution : (%f, %f), time : %f, iter : %d\n', sol, t_sol, iter); 

    subplot(2,3,i+length(f_set));contour(X,Y,cont_set{i}, 10);
    title(['powell func',num2str(i)]);
    %% Powell's method
    [sol, t_sol, simp_it, tot_it] = powell(f_set{i});
    fprintf('< Powell >\n');
    fprintf('solution : (%f, %f), time : %f, simple_iter : %d, tot_iter : %d\n\n', sol, t_sol, simp_it, tot_it);
end