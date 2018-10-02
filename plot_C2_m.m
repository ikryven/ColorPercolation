function plot_C2_m( mu, M, T );


N = size( M, 1 );
P = eye( N );
pp = linspace( 0.01, 0.99, 100 );

Pallete=color_palletes( 'de_stijl' );
textprogressbar( 'Computing profiles for <strong>C_2</strong> and <strong>m</strong>:    ' );
k=0;
CC = [];
MM = [];
for p = pp
    k=k+1;
    [ ~, M_p T_p ] = scale_muMT( mu, M, T, p );
    [ C2 m  ] = C_2_m_from_MTP(M_p, T_p, P );
    CC( end + 1 ) = C2;
    MM(end+1,1:N) = m;
    
    subplot(1,2,1)
    cla
    plot( pp( 1:length( CC ) ), CC, 'r-+','LineWidth',2 )
    ylim([0 0.1])
    xlabel('$p$','Interpreter','Latex')
    ylabel('$C_2$','Interpreter','Latex')
   
    subplot(1,2,2)
    cla
    for i=1:N
        plot( pp(1:length(CC)), MM(:,i),'-o','LineWidth',2, 'Color', Pallete(i,:) )
        hold on
    end;
    
    ylim([0 1])
    ylabel('$m_i$','Interpreter','Latex')
    xlabel('$p$','Interpreter','Latex')
    
    drawnow
    refresh
    textprogressbar(k/length(pp)*100)
end;

textprogressbar('            [ OK ]');
