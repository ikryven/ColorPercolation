function u = degree_distribution( param )
%{0
if param == 1
     %%
   [ X, Y, Z ] = meshgrid( 0 : 13 );
   

   
   u =   poisspdf( X, 1.5 ) .* (Y<1) .* (Z<1)...
       + poisspdf( Y, 2.5 ) .* (X<1) .* (Z<1)...
       + poisspdf( Z, 5 )   .* (X<1) .* (Y<1);
   
    u(  2, 2, 2 ) =   0;
    % u( 2, 2, 1 ) = 0.1;
    % u( 2, 1, 2 ) = 0.1;
    
          
    u( 1, 1, 1) = 0;
    u = u / sum( u( : ) );      
    
end;

if param == 2
    
     %%
   [ X, Y, Z ] = meshgrid( 0 : 13 );
   
   % don't change
   
   u =   poisspdf( X, 1.5 ) .* (Y<1) .* (Z<1)...
       + poisspdf( Y, 2.5 ) .* (X<1) .* (Z<1)...
       + poisspdf( Z, 5 )   .* (X<1) .* (Y<1);
   
    u(  2, 2, 2 ) =   0.1;

    
          
    u( 1, 1, 1) = 0;
    u = u / sum( u( : ) );      
    
end;

