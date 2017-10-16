function [X] = sort_func(f, X)
%% Copyright (C) 2017 Young-Chul Yoon
%% All rights reserved.

for i=1:length(X)-1
    for j = 1:length(X)-i
        if f(X{j}{:}) > f(X{j+1}{:})
            temp = X{j+1};
            X{j+1} = X{j};
            X{j} = temp;
        end
    end
end

end

