%% HW 1 AE 105 Emily Espinosa
% DESCRIPTION: This MATLAB script defines and tests a custom tridiagonal 
% matrix solver using the Thomas algorithm, a simplified form of Gaussian 
% elimination for tridiagonal systems.
function x = tridiagonal_solver(a, b, c, d)
    n = length(b);
    
    c_prime = zeros(n-1, 1);
    d_prime = zeros(n, 1);
    
    c_prime(1) = c(1) / b(1);
    d_prime(1) = d(1) / b(1);
    for i = 2:n
        denom = b(i) - a(i) * c_prime(i-1);
        if i < n
            c_prime(i) = c(i) / denom;
        end
        d_prime(i) = (d(i) - a(i) * d_prime(i-1)) / denom;
    end
    
    x = zeros(n, 1);
    x(n) = d_prime(n);
    for i = n-1:-1:1
        x(i) = d_prime(i) - c_prime(i) * x(i+1);
    end
end

a = [0; 1; 2; 2.5];
b = [2; 6; 9; 5];
c = [1; 2; 2.5; 0];
d = [-5.1; 12.3; -8.52; 7.32];
x2 = tridiagonal_solver(a, b, c, d);
disp(x2);

A1 = [3, -1, 0; 1, 2, 1; 0, -1, -3];
b1 = [6; -4; 0];
x1 = A1 \ b1; 
x1_builtin = A1 \ b1;

A2 = [2, 1, 0, 0; 1, 6, 2, 0; 0, 2, 9, 2.5; 0, 0, 2.5, 5];
b2 = [-5.1; 12.3; -8.52; 7.32];
x2_builtin = A2 \ b2;

rel_error1 = norm(x1 - x1_builtin) / norm(x1_builtin);
rel_error2 = norm(x2 - x2_builtin) / norm(x2_builtin);

disp(rel_error1);
disp(rel_error2);
