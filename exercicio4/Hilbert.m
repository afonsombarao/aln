function [H] = Hilbert(m,n)

% inicializar a matriz H
H = zeros(m, n);

% loop para substituir os valores pelos corretos
for i = 1:m
    for j = 1:n
        H(i, j) = 1 / (i + j - 1);
    end
end
end