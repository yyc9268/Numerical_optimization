function [solution, t_accum, iter] = linear_cg(f, start_pt)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Linear conjugate gradient

st = tic;
thresh = 1.0e-3;
pt = start_pt;

%% Define A as hessian matrix
H_val = my_hessian(f, pt);
%% When hessian is not positive
if H_val == 0 | check_positive(H_val) == false
    A = [10 1;1 5];
else
    A = H_val;
end

b = [0, 8]';

r = A*pt - b;
p = -r;
iter = 1;

pt_set = [];

while true
    pt_set = [pt_set, pt];
    %% Stop when norm of residue is smaller than threshold or time is over
    if norm(r) < thresh | toc(st) > 10
        solution = pt;
        t_accum = toc(st);
        break;
    end
    alpha = (r'*r)/(p'*A*p);
    pt = pt + alpha*p;
    prev_r = r;
    r = r + alpha*A*p;
    beta = (r'*r)/(prev_r'*prev_r);
    p = -r + beta*p;
    iter = iter + 1;
end

%% Draw converging process
hold on
plot(pt_set(1, :), pt_set(2, :), 'Color', 'r');
plot(pt_set(1, end), pt_set(2, end),'r*')
hold off

end
