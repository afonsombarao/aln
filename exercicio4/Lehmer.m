function [L] = Lehmer(m,n)
   
% matriz inicial
L = zeros(m,n);

% for loop para substituir os valores de L pelos suposto
for i = 1:m
    for j = 1:n;
        L(i,j) = min(i,j)./max(i,j);
    end
end
end