function [ solution, t_sol, simp_it, tot_it ] = powell(f)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Powell's method


%% Initial point, setting
N = 2;
X = {[200,-180]};
U = [1 0;0 1];
iter = 1;
accum_it = 0;
start = tic;
while true 
    %% Stopping criterion : Length of two recent point   
    if iter > 1 & sqrt((X{iter}(1)-X{iter-1}(1))^2 + (X{iter}(2)-X{iter-1}(2))^2) < 1.0e-3
        solution = X{end};    
        simp_it = iter-1;
        tot_it = iter-1 + accum_it;
        break;
    end
    
    P = {};
    P = [P, X(iter)];
    for n = 1:N      
        temp_u = U(:,n)';
       %% Univariate function of gamma
        new_f = @(gamma) f(P{n}(1) + gamma*temp_u(1), P{n}(2) + gamma*temp_u(2));
       %% Seeking bound algorithm
        [a, b] = bound_seeking(new_f);
       %% Golden section search
        [min_gam, t_gol, it_gol] = golden_section(new_f, a, b);
        accum_it = accum_it + it_gol;
        new_p = P{n} + min_gam*temp_u;
        P = [P, {new_p}];
    end
    for n = 1:N-1
        U(:,n) = U(:, n+1);
    end
    %% Find the best directions
    U(:,N) = (P{N}-P{1})';
    temp_u = U(:,N)';
    %% Univariate function of gamma
    new_f = @(gamma) f(P{1}(1) + gamma*temp_u(1), P{1}(2) + gamma*temp_u(2));
    %% Seeking bound algorithm
    [a, b] = bound_seeking(new_f);
    %% Golden section search
    [min_gam, t_gol, it_gol] = golden_section(new_f, a, b);
    accum_it = accum_it + it_gol;
    new_x = P{1} + min_gam*temp_u;
    X = [X, {new_x}];
    iter = iter+1;
end
t_sol = toc(start);
%% Draw converging process
plot_X = [];
for i = 1:length(X)
    plot_X = [plot_X, X{i}'];
end
hold on
plot(plot_X(1, :), plot_X(2, :), 'Color', 'r');
hold off

end