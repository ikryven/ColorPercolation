function f = Fz( z, K, T )

d = size( K, 1 );



S = T{ 1 } * ( 1 - sum( z ) );
for i = 1:d - 1
   
    S = S + T{ i + 1 } * z( i );
    
end;

 
f = 1/2 * [1; z]' * K' * inv( S ) * K * [1; z];

