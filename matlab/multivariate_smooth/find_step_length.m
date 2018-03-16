function [ step_length ] = find_step_length(f, pt, grad, p)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.

alpha = 10;
c = 0.5;
rho = 0.5;
t_accum = 0;

while true
    temp_st = tic;
    x = pt(1);
    y = pt(2);
    right = eval(f) + c*alpha*eval(grad')*p;
    x = pt(1) + alpha*p(1);
    y = pt(2) + alpha*p(2);
    left = eval(f);
    
    if left <= right | t_accum > 0.5
        step_length = alpha;
        return;
    else
        alpha = alpha*rho;
    end
    t_accum = t_accum + toc(temp_st);
end
