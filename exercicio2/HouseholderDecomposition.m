function [Q,R] = HouseholderDecomposition(A)

% obter a dimensao da matriz A
[rows, cols] = size(A);

% no enunciado diz que a funcao tem de receber uma matriz que nao pode ter
% menos linhas do que colunas
if rows < cols
    error('Erro: O número de colunas é maior que o de linhas.')
end

% guardar as matrizes de iteracao R e Q
R = A;
Q = eye(rows);

% inicializacao da iteracao
for i = 1:min(rows - 1, cols)

    % obtencao do vetor u para a reflexao de householder
    u = House(R(i:rows, i));
    
    % criacao da nova matriz P
    P_k = eye(rows);
    P_k(i:rows,i:rows) = eye(rows-i+1) - 2.*u*u.';

    % atualizacao da matriz R e Q
    R = P_k * R;
    Q = Q * P_k.';
end

end




