function [H_val] = my_hessian(f, pt)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.
%% 2x2 hessian function derivation
der_xx = diff(f, 'x', 'x');
der_xy = diff(f, 'x', 'y');
der_yx = diff(f, 'y', 'x');
der_yy = diff(f, 'y', 'y');
H = [der_xx, der_xy;der_yx, der_yy];
x = pt(1);
y = pt(2);
H_val = eval(H);

end

