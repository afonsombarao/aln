function [u] = House(x)
    
% obter o tamanho do vetor
n = max(size(x));

% criacao da matriz identidade para obter os vetores canonicos
I = eye(n);

% coeficiente alpha para criar o vetor v
alpha = - sign(x(1)).*norm(x);
v = x + alpha.*I(:,1);

% condicional para o caso de o vetor v ser identicamente nulo
if norm(v) == 0
    v = x
end

% normalizar o vetor v
u = v/norm(v);

end
