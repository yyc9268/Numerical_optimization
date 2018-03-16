function [ min_point, t_sol, sol_iter ] = nelder_mead(f)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Nelder and Mead Method

%% Initial setting
X = {{210, -110}, {170,-192}, {220,-200}};
alpha = 1;
gamma = 0.5;
beta = 2;
iter = 1;
t_sol = 0;

while true
    %% Draw triangle (Excluded from time checking)
    hold on
    draw_triangle(f, X);
    hold off
    temp_st = tic;
    %% Stopping criterion : area of triangle
    if tri_heron(X) < 1.0e-3
        sol_iter = iter-1;
        %% Traingle is sufficiently small and just return one of its point
        min_point = cell2mat(X{1});
        break;
    end
    %% Reflection
    X = sort_func(f, X);
    c = [0,0];
    for i=1:length(X)-1
        c = c + cell2mat(X{i});
    end
    c = c/(length(X)-1);
    x_r = num2cell(c + alpha*(c - cell2mat(X{end})));
    %% Continue
    if f(x_r{:}) <= f(X{end-1}{:}) & f(x_r{:}) >= f(X{1}{:})
        X{end} = x_r;
        continue;
    %% Expansion 
    elseif f(x_r{:}) <= f(X{1}{:})
        x_e = num2cell(c + beta*(cell2mat(x_r) - c));
        if f(x_e{:}) <= f(x_r{:})
            X{end} = x_e;
        else
            X{end} = x_r;
        end
    %% Contraction
    elseif f(x_r{:}) >= f(X{end-1}{:})
        if f(x_r{:}) < f(X{end}{:})
            x_c = num2cell(c + gamma*(cell2mat(x_r) - c));
        else
            x_c = num2cell(c + gamma*(cell2mat(X{end})));
        end
        if f(x_c{:}) < min(f(x_r{:}), f(X{end}{:}))
            X{end} = x_c;
        else
            for i=2:length(X)
                X{i} = num2cell((cell2mat(X{i})+cell2mat(X{1}))/2);
            end
        end
    end
    iter = iter+1;
    t_sol = t_sol + toc(temp_st);
end

end