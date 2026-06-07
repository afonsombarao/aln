function [X_out, iter, prec] = Newton_Schulz_test(A, n_max, epsilon)
    X_0 = A' / (norm(A, 'fro')^2);
    i = 0;
    X_1 = X_0;
    
    while i <= n_max 
        X_0 = X_1;
        X_1 = 2*X_0 - X_0*A*X_0;
        
        erro = norm(X_1 - X_0, 'fro');
        
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