function [X_out, iter, prec] = Newton_Schulz_erro_2_autoX0(A, n_max, epsilon)
    X_0 = A' / (norm(A, 'fro')^2);
    I = eye(size(A, 1));
    i = 0;
    R_k = I - A*X_0;
    norm_Rk = norm(R_k, 'fro');

    while norm_Rk >= 1 && i <= n_max
        X_0 = 2*X_0 - X_0*A*X_0;
        R_k = I - A*X_0;
        norm_Rk = norm(R_k, 'fro');
        i = i+1;
    end

    while i <= n_max 
        R_k = I - A*X_0;
        norm_Rk = norm(R_k, 'fro');
        erro = (norm(X_0, 'fro') * norm_Rk) / (1 - norm_Rk);

        if  erro < epsilon
            X_out = X_0;
            iter = i;
            prec = erro ;
            return;
        end
        
        X_0 = 2*X_0 - X_0*A*X_0;
        i = i + 1;
    end
    X_out = X_0;
    iter = n_max;
    prec = 'Não convergiu';
end