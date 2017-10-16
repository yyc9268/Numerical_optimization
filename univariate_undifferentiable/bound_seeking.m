function [a, b] = bound_seeking(f)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.

%% Initial point and d0
init_x = 10;
d0 = 0.01;

f_m = f(init_x - d0);
f0 = f(init_x);
f_p = f(init_x + d0);

d = 0;
x = [0, init_x, 0];

%% Set the sign of d
if f_m > f0 & f0 > f_p
    d = d0;
    x(1) = init_x - d0;
    x(3) = init_x + d0;
elseif f_m < f0 & f0 < f_p
    d = -d0;
    x(1) = init_x + d0;
    x(3) = init_x - d0;
elseif f_m > f0 & f0 < f_p
    a = init_x - d0;
    b = init_x + d0;
    return;
elseif f_m == f_p
    fprintf('f_m == f_p == f0\n');
    a = init_x - d0;
    b = init_x + d0;
    return;
else
    fprintf('init_x is maximum point\n');
    return;
end

k = 1;
while true
    if f(x(3))>f(x(2))
        if d>0
            a = x(1);
            b = x(3);
        else
            a = x(3);
            b = x(1);
        end
        return;
    end
    x_sav = x;
    %% Expand bound range using power of 2
    x(3) = x_sav(3)+(2^k)*d;
    x(2) = x_sav(3);
    x(1) = x_sav(2);
    k = k+1;
end

end

