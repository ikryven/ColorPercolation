function [H S] = H_z( z, K, T,T01 )

d = size( K, 1 );

S =  T{ 1 } * ( 1 - sum( z ) );
for i = 1:d - 1
   
    S = S + T{ i + 1 } * z( i );
    
end;



inv_S = inv( S );

E = eye(d);
H=zeros(d-1);
for i = 1:d-1
    for j = 1:d-1
        
        H( i, j ) =     E(i+1,:)  * K' * inv_S *  K * E(:,j+1)...
                       +[1; z]'   * K' * inv_S * ( T{i+1}-T{1} ) * inv_S * (T{j+1}-T{1} ) * inv_S * K * [1; z]...
                       -E(i+1,:)  * K' * inv_S * ( T{j+1}-T{1} ) * inv_S * K * [1; z]...
                       -[1; z]'   * K' * inv_S * ( T{i+1}-T{1} ) * inv_S * K * E(:,j+1) ;
        
    end;
end;
