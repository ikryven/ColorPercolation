function  [g_node w_avg v_star  ]=get_avgw_gnode_v( u, p )
max_itr=1000;

N=length(size(u));
[ Y X Z] = meshgrid( 0:( size( u, 2 ) - 1 ), 0:( size( u, 1 ) - 1 ), 0:( size( u, 3 ) - 1 ) );
x{1} = X;
x{2} = Y;
x{3} = Z;

[ mu M T ] = get_muMT( u );

s0=[1 1 1]'*0.5;

% 
c = 0;
residual = inf;
    while residual > 1e-5
        
       
        
        s = Ex1( u, mu, x, diag(p) * ( s0 - 1 ) + 1 )' ;

        residual  = sum( abs( s0 - s ) );
        s0 = s;
        c = c+1;
        if c>max_itr
            break
        end
    end    
c = c<max_itr;
    
g_node = 1 -  Ex( u, mu, x, diag(p) * ( s - 1 ) + 1 ) ;



P_edge_in_giant_given_color = 1 - s.^2;
P_edge_in_giant_given_color=P_edge_in_giant_given_color/sum(P_edge_in_giant_given_color);

P_color = mu/sum(mu);

P_edge_in_giant = sum( P_edge_in_giant_given_color .* P_color );

v_star = P_edge_in_giant_given_color .* P_color / P_edge_in_giant;


s1=diag( p ) * (s-1) + 1;

I=eye(3);
Y=[];
for i=1:3
    for j=1:3
        a=u.*( x{ i }.*x{ j } - ( i==j ) * x{ i } ) .* ...
                          s1( 1 ).^( x{ 1 }  - ( i == 1 )- ( j == 1 ) ).*...
                          s1( 2 ).^( x{ 2 }  - ( i == 2 )- ( j == 2 ) ).*...
                          s1( 3 ).^( x{ 3 }  - ( i == 3 )- ( j == 3 ) );
        Y(i,j) =  sum( a(:) ) / mu( i );

    end; 
    
end;


Y( isnan( Y ) ) = 0;
w_avg =   s' * diag( p ) * diag( mu ) * ( ( I - diag( p ) * Y ) \ s ) / ( 1 - g_node ) + 1;
w_avg = max( w_avg, 1 );



function s1 = Ex1( u, mu, x, s )


r = [];
for i = 1:length( s )
    r={};
    for j = 1:length( s )
        
        r{ j } = s( j ).^( x{ j }  - ( i == j ) ) ;
        
    end;
     
    s1( i ) = sum( x{ i }(:) .* r{ 1 }(:) .* r{ 2 }(:) .* r{ 3 }(:) .* u( : ) )/ mu( i );
    
end;
   





function s1 = Ex( u, mu, x, s )

r = {};

    for j = 1:length( s )
        
        r{ j } =  s( j ).^x{ j };
        
    end;
     
    s1 = sum( r{ 1 }(:) .* r{ 2 }(:) .* r{ 3 }(:) .* u( : ) );
    

   

