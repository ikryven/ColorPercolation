
Resolution = 15; %number of points for interpolation, increase for better resolution


%% CASE 1. alpha=0: multiple criticalities

u = degree_distribution( 1 );
[ mu M T ] = get_muMT( u );
figure(1)
plot_critical_manifolds( mu, M, T, Resolution);

%% CASE 2. alpha=0.1: multiple criticalities

u = degree_distribution( 2 );
[ mu M T ] = get_muMT( u );
figure(2)
plot_critical_manifolds( mu, M, T, Resolution);

