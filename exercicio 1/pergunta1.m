%%% Setup %%%

addpath('functions');

%%% Matrizes em estudo %%%

A = vander([1, 3, 5, 7, 9]); % Valendermor %

%%% Codigo em si %%%

epsilons = [0.1, 1e-3, 1e-6, 1e-9, 1e-12, 1e-15]; % O vetor dos \epsilons
n_max = 2000; %numero maximo de iteracoes que vamos utilizar

valores_iter_1 = zeros(length(epsilons), 1); % formula (12)
valores_iter_2 = zeros(length(epsilons), 1); % formula (13)
valores_iter_test = zeros(length(epsilons), 1); % valores para a \|X_{k+1}-X_K\|
valores_iter_test2 = zeros(length(epsilons), 1); % valores para a do \|R_k\|

for k = 1:length(epsilons) % para o primeiro tipo de aproximação 
    epsilon_atual = epsilons(k);
    
    [~, iter_1, ~] = Newton_Schulz_erro_1_autoX0(A,n_max,epsilon_atual);
    [~, iter_2, ~] = Newton_Schulz_erro_2_autoX0(A,n_max,epsilon_atual);
    [~, iter_3, ~] = Newton_Schulz_test(A,n_max,epsilon_atual);
    [~, iter_4, ~] = Newton_Schulz_test2(A,n_max,epsilon_atual);

    valores_iter_1(k) = iter_1;
    valores_iter_2(k) = iter_2;
    valores_iter_test(k) = iter_3;
    valores_iter_test2(k) = iter_4;
end

% Fazer a tabela

cabecalho = [{'Critério \ Epsilon'}, num2cell(epsilons)];

F1_texto = 'Formula (12)';
F2_texto = 'Formula (13)';
F3_texto = '\|X_{k+1}-X_k\|';
F4_texto = '\|R_k\|';

linha_F1 = [{F1_texto}, num2cell(valores_iter_1(:)')];

linha_F2 = [{F2_texto}, num2cell(valores_iter_2(:)')];

linha_F3 = [{F3_texto}, num2cell(valores_iter_test(:)')];

linha_F4 = [{F4_texto}, num2cell(valores_iter_test2(:)')];

TabelaFinal = [cabecalho; linha_F1; linha_F2; linha_F3; linha_F4];

clc;
disp(TabelaFinal);

%%% Restances matrizes

tamanhos = [5, 7, 10, 15, 20, 25];
matrizes_An = cell(length(tamanhos), 1);

%for i = 1:length(tamanhos) % Matriz A_n
    %n = tamanhos(i); 

    %d_principal = 10 * ones(n, 1);
    %d_principal(1) = 9;

    %d_secundaria = 3 * ones(n-1, 1);

    %An = diag(d_principal) + diag(d_secundaria, 1) + diag(d_secundaria, -1);

    %matrizes_An{i} = An;
%end

%for i = 1:length(tamanhos) % Matriz de Hilbert
    %n = tamanhos(i); 
    %An = hilb(n);
    %matrizes_An{i} = An;
%end

for i = 1:length(tamanhos) % Matriz de Hilbert
    n = tamanhos(i); 
    An = gallery('lehmer', n);
    matrizes_An{i} = An;
end

%%% restante código
epsilons = [0.1, 1e-3, 1e-6, 1e-9, 1e-12, 1e-15];
n_max = 2000;

% tamanho das matrizes
valores_iter_5 =  zeros(length(epsilons), 1);
valores_iter_7 =  zeros(length(epsilons), 1);
valores_iter_10 =  zeros(length(epsilons), 1);
valores_iter_15 =  zeros(length(epsilons), 1);
valores_iter_20 =  zeros(length(epsilons), 1);
valores_iter_25 =  zeros(length(epsilons), 1);

for k = 1:length(epsilons) % para o primeiro tipo de aproximação 
    epsilon_atual = epsilons(k);

    [~, iter_5, ~] = Newton_Schulz_erro_1_autoX0(matrizes_An{1},n_max,epsilon_atual);
    [~, iter_7, ~] = Newton_Schulz_erro_1_autoX0(matrizes_An{2},n_max,epsilon_atual);
    [~, iter_10, ~] = Newton_Schulz_erro_1_autoX0(matrizes_An{3},n_max,epsilon_atual);
    [~, iter_15, ~] = Newton_Schulz_erro_1_autoX0(matrizes_An{4},n_max,epsilon_atual);
    [~, iter_20, ~] = Newton_Schulz_erro_1_autoX0(matrizes_An{5},n_max,epsilon_atual);
    [~, iter_25, ~] = Newton_Schulz_erro_1_autoX0(matrizes_An{6},n_max,epsilon_atual);

    valores_iter_1(k) = iter_5;
    valores_iter_2(k) = iter_7;
    valores_iter_3(k) = iter_10;
    valores_iter_4(k) = iter_15;
    valores_iter_5(k) = iter_20;
    valores_iter_6(k) = iter_25;
end

cabecalho = [{'Iteração por tamnho'}, num2cell(epsilons)];

F1_texto = 'n = 5';
F2_texto = 'n = 7';
F3_texto = 'n = 10';
F4_texto = 'n = 15';
F5_texto = 'n = 20';
F6_texto = 'n = 25';

linha_F1 = [{F1_texto}, num2cell(valores_iter_1(:)')];
linha_F2 = [{F2_texto}, num2cell(valores_iter_2(:)')];
linha_F3 = [{F3_texto}, num2cell(valores_iter_3(:)')];
linha_F4 = [{F4_texto}, num2cell(valores_iter_4(:)')];
linha_F5 = [{F5_texto}, num2cell(valores_iter_5(:)')];
linha_F6 = [{F6_texto}, num2cell(valores_iter_6(:)')];

TabelaFinal = [cabecalho; linha_F1; linha_F2; linha_F3; linha_F4;linha_F5;linha_F6];

clc;
disp(TabelaFinal);



%%% Matrizes invercas %%%

n = 10;
epsilon = 1e-12;
n_max = 10000;
matrizes_An = cell(3, 1);

d_principal = 10 * ones(n, 1);
d_principal(1) = 9;

d_secundaria = 3 * ones(n-1, 1);

A = diag(d_principal) + diag(d_secundaria, 1) + diag(d_secundaria, -1);
B = hilb(n);
C = gallery("lehmer",n);

matrizes_An{1} = A;
matrizes_An{2} = B;
matrizes_An{3} = C;

for k = 1:length(matrizes_An)%n
    A_n = matrizes_An{k};
    %A_n = hilb(k);
    [X_out ,~ ,~ ] = Newton_Schulz_erro_1_autoX0(A_n,n_max,epsilon);
    disp(inv(A_n))
    disp(X_out)
    %N = norm(X_out-inv(A_n),'fro');
    %fprintf("%d\n",N)
end


%%% Ordem de convergência %%%

n = 48;
I = eye(n);
I2 = eye(5);

d_principal = 10 * ones(n, 1);
d_principal(1) = 9;
d_secundaria = 3 * ones(n-1, 1);

A = diag(d_principal) + diag(d_secundaria, 1) + diag(d_secundaria, -1);
B = hilb(n);
C = gallery('lehmer',n);
D = vander([1, 3, 5, 7, 9]);

X_0_A = A' / (norm(A, 'fro')^2);
X_0_B = B' / (norm(B, 'fro')^2); 
X_0_C = C' / (norm(C, 'fro')^2); 
X_0_D = D' / (norm(D, 'fro')^2); 

R_0_A = I - A*X_0_A;
R_1_A = R_0_A*R_0_A;
R_2_A = R_1_A*R_1_A;
R_0_B = I - B*X_0_B;
R_1_B = R_0_B*R_0_B;
R_2_B = R_1_B*R_1_B;
R_0_C = I - C*X_0_C;
R_1_C = R_0_C*R_0_C;
R_2_C = R_1_C*R_1_C;
R_0_D = I2 - D*X_0_D;
R_1_D = R_0_D*R_0_D;
R_2_D = R_1_D*R_1_D;

valores_p_A = zeros(n,1);
valores_p_B = zeros(n,1);
valores_p_C = zeros(n,1);
valores_p_D = zeros(n,1);

for k = 1:n
    p_A = (log(norm(R_2_A,'fro'))-log(norm(R_1_A,'fro')))/(log(norm(R_1_A,'fro'))-log(norm(R_0_A,'fro')));
    p_B = (log(norm(R_2_B,'fro'))-log(norm(R_1_B,'fro')))/(log(norm(R_1_B,'fro'))-log(norm(R_0_B,'fro')));
    p_C = (log(norm(R_2_C,'fro'))-log(norm(R_1_C,'fro')))/(log(norm(R_1_C,'fro'))-log(norm(R_0_C,'fro')));
    p_D = (log(norm(R_2_D,'fro'))-log(norm(R_1_D,'fro')))/(log(norm(R_1_D,'fro'))-log(norm(R_0_D,'fro')));
    
    valores_p_A(k) = p_A;
    valores_p_B(k) = p_B; 
    valores_p_C(k) = p_C; 
    valores_p_D(k) = p_D; 

   R_0_A = R_1_A;  R_1_A = R_2_A;  R_2_A = R_1_A*R_1_A;
   R_0_B = R_1_B;  R_1_B = R_2_B;  R_2_B = R_1_B*R_1_B;
   R_0_C = R_1_C;  R_1_C = R_2_C;  R_2_C = R_1_C*R_1_C;
   R_0_D = R_1_D;  R_1_D = R_2_D;  R_2_D = R_1_D*R_1_D;
end



%cabecalho = [{'Iteração'}, num2cell(3:n+2)];
%texto = "Valor de p";
%Linha = [{texto}, num2cell(valores_p(:)')];

%TabelaFinal = [cabecalho; Linha];

%clc;
%disp(TabelaFinal);

figure;
hold on;

plot(3:n+2, valores_p_A, '-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'b', 'DisplayName', 'Matriz A (Tridiagonal)');
plot(3:n+2, valores_p_B, '-s', 'LineWidth', 1.5, 'MarkerFaceColor', 'r', 'DisplayName', 'Matriz B (Hilbert)');
plot(3:n+2, valores_p_C, '-^', 'LineWidth', 1.5, 'MarkerFaceColor', 'g', 'DisplayName', 'Matriz C (Lehmer)');
plot(3:n+2, valores_p_D, '-d', 'LineWidth', 1.5, 'MarkerFaceColor', 'm', 'DisplayName', 'Matriz D (Vandermonde)');

hold off;

grid on;
title('Evolução da Ordem de Convergência Computacional (p)');
xlabel('Número da Iteração (k)');
legend('show', 'Location', 'best');
ylabel('Valor de p'); 
ylim([0.5 2.5]); 