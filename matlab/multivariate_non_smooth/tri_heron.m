function [area] = tri_heron(X)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% Area of a triangle calculation
%% Heron's formula

x1 = cell2mat(X{1});
x2 = cell2mat(X{2});
x3 = cell2mat(X{3});
t_a = x1 - x2;
t_b = x2 - x3;
t_c = x3 - x1;
a = sqrt(t_a(1)^2 + t_a(2)^2);
b = sqrt(t_b(1)^2 + t_b(2)^2);
c = sqrt(t_c(1)^2 + t_c(2)^2);

s = (a + b + c)/2;
area = sqrt(s*(s-a)*(s-b)*(s-c));

end

