function [x, interv, t, it] = fibonacci_search(f, a, b, N)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.

tic;

%% Generate N fibonacci numbers
f_num = [];
f_num = [f_num, 1];
f_num = [f_num, 1];
for i=3:N
    f_num = [f_num, (f_num(i-1) + f_num(i-2))];
end

%% Iterate maximum N epoch
it = 1;
for i=N:-1:3
    L = b-a;
    x1 = a+(f_num(i-2)/f_num(i))*L;
    x2 = b-(f_num(i-2)/f_num(i))*L;
    if x1 == x2
        break;   
    elseif f(x1)>f(x2)
        a = x1;
    else
        b = x2;
    end
    it = it+1;
end
t = toc;
x = b;
interv = b-a;

end