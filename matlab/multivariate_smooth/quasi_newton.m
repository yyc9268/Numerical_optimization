function [ solution, t_accum ] = quasi_newton(f, start_pt, t_limit, mode)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Quasi newtons method (SR1, BFGS)

temp_st = tic;
der_x = diff(f, 'x');
der_y = diff(f, 'y');
grad = [der_x, der_y]';

%% Setting initial value
pt = start_pt;
B = eye(2);
x = pt(1);
y = pt(2);

pt_set = [];
t_accum = toc(temp_st);;

%% SR1
if strcmp(mode, 'sr1')
    while true
        temp_st = tic;
        pt_set = [pt_set, pt];
        %% Stopping criterion
        if norm(eval(grad)) < 1.0e-3 | t_accum > t_limit
            solution = pt';
            break;
        end
        %% Derive H from inverse of B
        H = inv(B);
        p = -H*eval(grad);
        
        prev_pt = pt;
        %% Step length calculation
        step_length = find_step_length(f, pt, grad, p);
        s = step_length*p;
        pt = pt + s;
        
        x = prev_pt(1);
        y = prev_pt(2);
        old_grad = eval(grad);
        x = pt(1);
        y = pt(2);    
        mv_grad = eval(grad); 
        
        y_k = mv_grad - old_grad;
        prev_B = B;
        divisor = (y_k - B*s)'*s;
        B = B + (y_k - B*s)*(y_k - B*s)'./divisor;
        %% Strategy to avoid break down
        if divisor < 0.5*norm(s)*norm(y_k-B*s) | divisor <= 0
            B = prev_B;
        end
        t_accum = t_accum + toc(temp_st);
    end
%% BFGS
elseif strcmp(mode, 'bfgs')
    %% In BFGS, we directly derive H
    H = B;
    while true
        temp_st = tic;
        pt_set = [pt_set, pt];
        %% Stopping criterion
        if norm(eval(grad)) < 1.0e-3 | t_accum > t_limit
            solution = pt;
            break;
        end
        p = -H*eval(grad);
        
        prev_pt = pt;
        %% Step length calculation
        step_length = find_step_length(f, pt, grad, p);
        pt = pt + step_length*p;

        x = prev_pt(1);
        y = prev_pt(2);
        old_grad = eval(grad);
        x = pt(1);
        y = pt(2);
        mv_grad = eval(grad);
        
        y_k = mv_grad - old_grad;
        s = pt - prev_pt;
        
        rho = 1./(y_k'*s);
        H = (eye(2)-rho*s*y_k')*H*(eye(2)-rho*y_k*s')+rho*s*s';
        t_accum = t_accum + toc(temp_st);
    end
else
    disp('Not implemented method (Use sr1 or bfgs');
end

%% Draw converging process
hold on
plot(pt_set(1, :), pt_set(2, :), 'Color', 'r');
plot(pt_set(1, end), pt_set(2, end),'r*')
hold off

end