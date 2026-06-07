function [X_out, iter, prec] = Newton_Schulz_test2(A, n_max, epsilon)
    X_0 = A' / (norm(A, 'fro')^2); 
    I = eye(size(A, 1));
    i = 0; 
    
    while i <= n_max 
        R_k = I-A*X_0;
        X_0 = 2*X_0 - X_0*A*X_0;
         
        erro = norm(R_k, 'fro');
        
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