function draw_triangle(f, X)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.

%% Warning : Added z + 1 because of visibility
t1 = cell2mat(X{1});
%t1 = [t1, f(X{1}{:})];
t2 = cell2mat(X{2});
%t2 = [t2, f(X{2}{:})];
t3 = cell2mat(X{3});
%t3 = [t3, f(X{3}{:})];
tri = [t1', t2', t3', t1'];
plot(tri(1, :), tri(2, :), 'Color', 'r');

end

