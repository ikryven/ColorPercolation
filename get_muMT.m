function [mu M T] = get_muMT( u );

N=length(size(u));
[ Y X Z] = meshgrid( 0:( size( u, 2 ) - 1 ), 0:( size( u, 1 ) - 1 ), 0:( size( u, 3 ) - 1 ) );
x{1}=X;
x{2}=Y;
x{3}=Z;

for i=1:N
    mu(i) =  E( u, x, i ) ;
end;   
mu = mu(:);


S=[];
for i=1:N
    for j=1:N
        S(i,j) = E( u, x, i, j )  ; 
    end
end
M = S ./ repmat( mu', N, 1 )- eye( N );



T = {};
for i=1:N
    for j=1:N
        for l=1:N
            T{i}(j,l) =  (E( u, x, i, j, l ) / mu(i) - E( u, x, i, j ) * E( u, x, i, l ) / mu(i)^2 );
        end
    end
end

TS = {};
for i=1:N
    for j=1:N
        for l=1:N
            TS{i}(j,l) =  E( u, x, i, j, l );
        end
    end
end


function EX = E( u, x, varargin )

    f = 1;
    for i = 1:length( varargin )
        f = f .* x{ varargin{ i } };
    end;

    EX = sum( f(:) .* u(:) );



