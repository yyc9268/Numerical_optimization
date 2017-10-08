function [x, t, it] = golden_section(f, a, b)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.

tic;

rho = 0.6180;
tol = 1.0e-3;

%% Iterate until interval of two points is less than tolerance
it = 1;
while true
    if (abs(a-b) < tol)  
        break;
    end
    x1 = a + (1-rho)*(b-a);
    x2 = a + rho*(b-a);
    if f(x2)>f(x1)
        b = x2;
    else
        a = x1;
    end
    it = it+1;
end
t = toc;
x = b;

end