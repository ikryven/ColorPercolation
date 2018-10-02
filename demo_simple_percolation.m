

%% CASE 1. alpha=0: multiple criticalities

u = degree_distribution( 1 );
[ mu M T ] = get_muMT( u );

% asyptotic distribution and structure in finite components
figure( 1 )
plot_C2_m( mu, M, T );

% asyptotic distribution and structure in the giant components
figure( 2 )
plot_avgw_gnode_v( u );



%% CASE 2. alpha=0.1: single criticality 

u = degree_distribution( 2 );
[ mu M T ] = get_muMT( u );

% asyptotic distribution and structure in finite components
figure( 3 )
plot_C2_m( mu, M, T );

% asyptotic distribution and structure in the giant components
figure( 4 )
plot_avgw_gnode_v( u );


%%




