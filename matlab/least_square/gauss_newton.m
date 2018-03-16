function [a, b, c, d, sum_sq, t, iter] = gauss_newton(f, data)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Gauss-Newton


t_st = tic;

x_dat = data(:,1);
y_dat = data(:,2);
z_dat = data(:,3);
f_dat = data(:,4);
m = length(data(:,1));

%% Initial guess
B = [-3, 8, 23, 9]';
sum_sq = inf;
iter = 1;

while true
    %% Calculate residue
    r = [];
    for i=1:m
        arg = [x_dat(i) y_dat(i) z_dat(i) B(1) B(2) B(3) B(4)];
        temp_r = f_dat(i) - subs(f, {'x', 'y', 'z', 'a', 'b', 'c', 'd'}, arg);
        r = [r;temp_r]; 
    end
    r = eval(r);

    %% Calculate jacobian
    j = [];
    for i=1:m
        x = x_dat(i);
        y = y_dat(i);
        z = z_dat(i);
        arg = [x y z];
        r_f = subs(f, {'x', 'y', 'z'}, arg);
        der_a = diff(r_f, 'a');
        der_a = subs(der_a, {'a', 'b', 'c', 'd'}, B');
        der_b = diff(r_f, 'b');
        der_b = subs(der_b, {'a', 'b', 'c', 'd'}, B');
        der_c = diff(r_f, 'c');
        der_c = subs(der_c, {'a', 'b', 'c', 'd'}, B');
        der_d = diff(r_f, 'd');
        der_d = subs(der_d, {'a', 'b', 'c', 'd'}, B');
        temp_j = [der_a, der_b, der_c, der_d];
        j = [j;temp_j];
    end 
    J = eval(j);
    
    %% Compute new directioni
    p = -inv(J'*J)*J'*r;
    
    %% Calculate new guess
    B = B - 0.5*p;
    
    prev_sum = sum_sq;
    %% Calculate sum of squares
    sum_sq = 0;
    for i=1:m
        sum_sq = sum_sq + r(i)^2;
    end
    fprintf('<%dth> Sum of squre : %f\n', iter, sum_sq);
    
    %% Terminate condition 
    if norm(sum_sq - prev_sum) < 1.0e-3
        t = toc(t_st);
        a = B(1);
        b = B(2);
        c = B(3);
        d = B(4);
        return;
    end 
    iter = iter + 1;
end
