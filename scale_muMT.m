function [ mu M T ] = scale_muMT( mu, M, T, p)
%provides scaled matrices mu M T for color dependent percolatin when p is a vector, 
%and for colour independent percolation when p is a  scalar.

N = size( M, 1 );

if length( p ) == 1
    p = p * ones( N, 1 );
end

for i = 1:N
    T{i}  = diag(p)  * T{i} * diag(p) + diag(p) * diag(1-p) * diag( M( :, i ) ) ;
end;

mu = diag( p ) * mu;
M  = diag( p ) * M;
