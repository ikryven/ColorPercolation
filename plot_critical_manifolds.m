function plot_critical_manifolds( mu, M, T, RES )


N = size( M,1 );
I   = eye( N );

xx = linspace( 0.01, 0.99, RES );
[ X, Y, Z ] = meshgrid( xx, xx, xx );
x = X(:);
y = Y(:);
z = Z(:);

F = [];
G = [];
C = [];
warning off;
textprogressbar('Computing critical manifolds     ')
for i=1:length( x )
    p      = [ x(i) y(i) z(i) ];
    
    [ ~, M1, T1 ] = scale_muMT( mu, M, T, p );
    C2  = C_2_m_from_MTP( M1, T1, I );
   
    F( i )   = det(  I -  M * diag( p ) );
    [ V  D ] = eigs( I -  M * diag( p ) );
    
    D = diag(D);
    
    [ ~, j ] = min( abs( D ) );
    
    V = V( :, j );
    V = V / sum( V );
    G( i ) = all( V >= 0 );
    C(i)=C2;
    textprogressbar(i/length(x)*100);
end
F = reshape( F, size( X ) );
G = reshape( G, size( X ) );
C = reshape( C, size( X ) );
textprogressbar('        [ OK ]')
%% plotting
cla
hold
G(G==0) = inf;
S1 = F .* G;

S2 = C;

subplot(1,2,1)
cla
lambda = 0.001;
pa = patch(isosurface( X, Y, Z, S1, lambda ));
isonormals(X,Y,Z,S1,pa);

pa.FaceColor = 'red';
pa.EdgeColor = 'none';

pa = patch( isosurface( X, Y, Z, S1, -lambda  ) );
isonormals(X,Y,Z,S1,pa)

pa.FaceColor = 'blue';
pa.EdgeColor = 'none';

view(3); 
axis tight
camlight 
lighting gouraud
 
xlim([0 1])
ylim([0 1])
zlim([0 1])
view( [ 20, 10 ] )
set(gca,'color','k')
set(gcf,'color','k')
set(gca,'XColor','w')
set(gca,'YColor','w')
set(gca,'ZColor','w')
box on


subplot(1,2,2)

lambda = 0.02;
pa = patch(isosurface( X, Y, Z, S2, lambda *1.001));
isonormals(X,Y,Z,S2,pa);

pa.FaceColor = 'red';
pa.EdgeColor = 'none';

pa = patch( isosurface( X, Y, Z, S2, lambda * 0.999 ) );
isonormals(X,Y,Z,S2,pa)

pa.FaceColor = 'blue';
pa.EdgeColor = 'none';

view(3); 
axis tight
camlight 
lighting gouraud
 
xlim([0 1])
ylim([0 1])
zlim([0 1])
view( [ 20, 10 ] )
set(gca,'color','k')
set(gcf,'color','k')
set(gca,'XColor','w')
set(gca,'YColor','w')
set(gca,'ZColor','w')
box on

