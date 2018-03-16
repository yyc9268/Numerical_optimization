function [solution, t_accum] = multi_newtons(f, start_pt, t_limit)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Newtons method for multivariate problem

temp_st = tic;
pt = start_pt;
der_x = diff(f, 'x');
der_y = diff(f, 'y');
grad = [der_x, der_y]';

%% Define hessian matrix
der_xx = diff(f, 'x', 'x');
der_xy = diff(f, 'x', 'y');
der_yx = diff(f, 'y', 'x');
der_yy = diff(f, 'y', 'y');
H = [der_xx, der_xy;der_yx, der_yy];
t_accum = toc(temp_st);

pt_set = [];

while true
    pt_set = [pt_set, pt];
    x = pt(1);
    y = pt(2);
    temp_st = tic;
    %% Stopping criterion
    if norm(eval(grad)) < 1.0e-3 | t_accum > t_limit
        solution = pt';
        break;
    end
    p = - inv(eval(H))*eval(grad);
    %% Step length calculation
    step_length = find_step_length(f, pt, grad, p);
    pt = pt + p.*step_length;
    t_accum = t_accum + toc(temp_st);
end

%% Draw converging process
hold on
plot(pt_set(1, :), pt_set(2, :), 'Color', 'r');
plot(pt_set(1, end), pt_set(2, end),'r*')
hold off

end