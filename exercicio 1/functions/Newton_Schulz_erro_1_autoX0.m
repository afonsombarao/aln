function [X_out, iter, prec] = Newton_Schulz_erro_1_autoX0(A, n_max, epsilon)
    X_0 = A' / (norm(A, 'fro')^2); 
    I = eye(size(A, 1));
    i = 0;
    X_1 = X_0;
    R_k = I - A*X_0;       
    norm_Rk = norm(R_k, 'fro');

    while norm_Rk >= 1 && i <= n_max
            X_0 = X_1;
            X_1 = 2*X_0 - X_0*A*X_0;
            R_k = I - A*X_0;       
            norm_Rk = norm(R_k, 'fro');
            i = i+1;
    end

    while i <= n_max 
        X_0 = X_1;
        X_1 = 2*X_0 - X_0*A*X_0;
        R_k = I - A*X_0;       
        norm_Rk = norm(R_k, 'fro');
        erro = norm(X_1 - X_0, 'fro') / (1 - norm_Rk);
        
        if  erro < epsilon 
            X_out = X_0;
            iter = i;
            prec = erro;
            return;
        end

        i = i + 1;
    end
    X_out = X_0;
    iter = n_max;
    prec = 'Não convergiu';
end