function v = Gauss_Elim(A,b)
%v = Gauss_Elim(A,b):
%   GAUSS_ELIM solves linear equations 
%   expressed in matrix form Av = b 
%   using Gaussian Elimination with total pivoting.
%   Input A = square matrix of coefficients
%   Input b = vector of constants 
%   Output v = solution vector.

% Version 1.1: created 18/02/21. Original Author: Paul Curran.
% Adapted by Daniel Jakob. 

% Error Checking
% A needs to be nxn matrix 
% b needs to be nx1 vector
[rowsA,colsA] = size(A);
[rowsb,colsb] = size(b);
if ~(rowsA == colsA) || ~(colsb == 1) || ~(rowsb == rowsA) || ~ismatrix(A)
    error('Matrix A must be a square matrix and b must be a column vector')
end
if ~isreal(A) || ~isreal(b)
    error('Matrix A and b must be made of real numbers only')
end
if ~ismatrix(A) || ~ismatrix(b)
    error('Inputs A and b must be a matrix and array respectively')
end

Ra = size(A);
n = Ra(1);
Id = eye(n);
Q_tot = Id;
A1 = A; % running values of A 
b1 = b; % running values of b

for m = 1:n-1
    % Total Pivoting
    row_index = [m:n];
    [Yc,Ir] = max(abs(A1(row_index, row_index)));
    [~,Ic1] = max(Yc);
    row_num = Ir(Ic1);
    col_num = Ic1;
    p = [1:n]; p(m) = m-1+row_num; p(m-1+row_num) = m;
    q = [1:n]; q(m) = m-1+col_num; q(m-1+col_num) = m;
    P = Id(p,:); Q = Id(:,q);
    A1 = P*A1*Q; b1 = P*b1; Q_tot = Q*Q_tot;

    % Elimination
    I_vec = zeros(1,n); I_vec(1,m) = 1;
    if A1(m, m) == 0 % check that division of zero doesnt take place
        sprintf('Cannot divide by 0')
    end
    L1 = Id - ([zeros(m,1);A1(m+1:n,m)]*I_vec)/A1(m,m);
    A1 = L1*A1; b1 = L1*b1;
end

% Back Substitution 

v = zeros(n,1);
for m = 0:n-1
    if A1(n-m, n-m) == 0 % check that division of zero doesnt take place
        sprintf('Cannot divide by 0')
    end
    v(n-m,1) = (b1(n-m,1) - (A1(n-m,:)*v))/A1(n-m,n-m);
end

v = Q_tot'*v;

end