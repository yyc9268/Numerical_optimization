function [solution, t_accum, iter] = nonlinear_cg(f, start_pt)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Non-linear conjugate gradient

st = tic;
thresh = 1.0e-3;

pt = start_pt;

der_x = diff(f, 'x');
der_y = diff(f, 'y');
grad = [der_x, der_y]';

x = pt(1);
y = pt(2);
p = -eval(grad);
cur_grad = eval(grad);
iter = 1;

pt_set = [];

while true
    pt_set = [pt_set, pt];
    %% Stop when gradient is smaller than threshold or time is over
    if norm(cur_grad) < thresh | toc(st) > 10
        solution = pt;
        t_accum = toc(st);
        break;
    end
    %% Compute alpha
    alpha = find_step_length(f, pt, grad, p);
    pt = pt + alpha*p;
    x = pt(1);
    y = pt(2);
    pr_grad = cur_grad;
    %% Compute gradient
    cur_grad = eval(grad);
    beta = (cur_grad'*cur_grad)/(pr_grad'*pr_grad);
    p = -cur_grad + beta*p;
    iter = iter + 1;
end

%% Draw converging process
hold on
plot(pt_set(1, :), pt_set(2, :), 'Color', 'r');
plot(pt_set(1, end), pt_set(2, end),'r*')
hold off

end
