function plot_avgw_g_node_v(u)

pp = linspace(0.001,0.999,200);

textprogressbar( 'Computing profiles for <strong>g_node</strong>, <strong>avg.w</strong>, and <strong>v*</strong>:   ' );

g_nodes = [];
w_avgs = [];
edge_fractions=[];
k=0;
for p = pp;
k=k+1;
[ g_node w_avg v_star  ] = get_avgw_gnode_v( u, p );
g_nodes( end + 1 ) = g_node;
w_avgs( end + 1 )  = w_avg;
edge_fractions(:,end+1) = v_star;

%% plotting
subplot(1,3,1)
cla
plot(pp(1:size(edge_fractions,2)), g_nodes,'r-','LineWidth', 2  );
xlabel('$p$','Interpreter','Latex')
ylabel('$g_{node}$','Interpreter','Latex')
ylim([0 1])
subplot(1,3,2)
cla
plot(pp(1:size(edge_fractions,2)), w_avgs,'r-','LineWidth',2  );
xlabel('$p$','Interpreter','Latex')
ylabel('$E[n^2]/E[n]$','Interpreter','Latex')
ylim([0 10])
subplot(1,3,3)
plot(pp(1:size(edge_fractions,2)), edge_fractions./(g_nodes>0.01),'o-','LineWidth',2  );
ylim([0 1])
xlim([0 1])
xlabel('$p$','Interpreter','Latex')
ylabel('$v_i^*$','Interpreter','Latex')

drawnow
refresh
textprogressbar(k/length(pp)*100);

end;
textprogressbar('         [ OK ]')

