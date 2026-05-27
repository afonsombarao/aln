% funcao principal do script, a funcao que calcula o numero de condicao a
% partir das funcoes auxiliares dos metodos das potencias

function [cond2] = cond2(A, x_0, epsilon)

% calcular os dois lambdas atraves das funcoes auxiliares
lambda_max = metodo_potencias(A,x_0,epsilon);
lambda_min = metodo_potencias_inversas(A, x_0,epsilon);

cond2 = lambda_max / lambda_min;

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% x_0 tem de ser vetor coluna
function [lambda_max] = metodo_potencias(A, x_0, epsilon)

% inicializacao do algoritmo com os arrays que vao guardar os varios
% valores de lambda, x e z.
lambda = [0, Inf]; % pus estes valores para nao dar erro na primeira iteracao do while loop
x = [x_0];
z = [];
n = max(size(x_0));

% ciclo while para correr ate atingir a tolerancia fornecida
while abs(lambda(end) - lambda(end-1)) >= epsilon

    % atualizacao do vetor z e definicao de j para ter uma componente de
    % x^(k) != 0
    z = [z, A*x(:,end)];
    j = 0;
    for i=1:n
        if x(i,end) ~= 0
            j = i;
            break
        end
    end

    % atualizacao dos vetores lambda e x
    lambda = [lambda, z(j, end)/x(j, end)];
    x = [x, z(:,end)/lambda(end)];
end

% sabendo que o metodo converge, podemos admitir que o lambda_max
% corresponde ao ultimo elemento de lambda
lambda_max = abs(lambda(end));

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% em seguida encontra-se a funcao que vai computar min|lambda|

% iremos usar a decomposicao QR de householder ja implementada para
% decompor a matriz A por forma a resolver os sistemas
function [lambda_min] = metodo_potencias_inversas(A, x_0, epsilon)

% inicializacao das variaveis
lambda = [0, Inf];
x = [x_0];
z = [];
n = max(size(x_0));

% decomposicao QR de Householder para resolucao do sistema linear
[Q, R] = HouseholderDecomposition(A);
Rinv = inv(R);

% daqui para a frente a logica e a mesma da funcao anterior
while abs(lambda(end)-lambda(end-1)) >= epsilon
    z = [z, Rinv*Q.'*x(:,end)];
    j = 0;
    for i=1:n
        if x(i,end) ~= 0
            j = i;
            break
        end
    end

    lambda = [lambda, z(j, end)/x(j, end)];
    x = [x, z(:,end)/lambda(end)];

end
 
% uma vez que o algoritmo das potencias inversas devolve 1/lambda_min, para
% obter lambda_min temos de inverter esse valor
lambda_min = abs(1/lambda(end));

end