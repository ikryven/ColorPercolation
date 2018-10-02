function  [C2 m Sigma]=C_2_m_from_MTP( M, T, P )
% computes asymptote exponent C_2, 
% and color distribution parameters m and Sigma 
% form the moments of the degree distribution mu, M, and T

N = size( M, 1 );

A      = eye( N );
A( 1, : ) = 1;

K = ( M - P ) * inv( A );

options = optimoptions( 'fmincon' );
options.ConstraintTolerance = 1e-10;
options.OptimalityTolerance = 1e-10;
options.StepTolerance       = 1e-10;
options.Display='off';
[ z f ] = fmincon( @(x) Fz( x, K, T ), ones(N-1,1)/N, ones(1,N-1), 1, [], [], zeros(N-1,1), ones(N-1,1), [], options );

C2 = f;
m = [ 1 - sum( z ); z ]';
[ H S ] = H_z( z, K, T );
Sigma = inv(H);
