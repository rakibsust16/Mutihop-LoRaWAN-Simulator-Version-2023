
rng(0)
node=[50 100 200 300 400 500];
figure(1)
pdr50=[0.9397 0.70803 0.7919 0.82981 0.67945 0.71657 0.81245];
pdr100=[0.87949 0.56858 0.65883 0.78038 0.56067 0.50721 0.72618];
pdr200=[0.73878 0.42419 0.43842 0.61694 0.41108 0.31637 0.55147];
pdr300=[0.63551 0.30111 0.34903 0.48105 0.30291 0.23258 0.44474];
pdr400=[0.549640052398524 0.25543582777837 0.290395267525617 0.396757041596522 0.224633026372247 0.173713970897318 0.392775729921225];
pdr500=[0.47332 0.2063 0.22954 0.35024 0.18841 0.14016 0.32847];
pdrsh=[pdr50(1) pdr100(1) pdr200(1) pdr300(1) pdr400(1) pdr500(1)];
pdrnh=[pdr50(5) pdr100(5) pdr200(5) pdr300(5) pdr400(5) pdr500(5)];
pdrvh=[pdr50(4) pdr100(4) pdr200(4) pdr300(4) pdr400(4) pdr500(4)];%122


% Define the line colors
pdr_color_sh = [0.2 0.4 0.6]; % blue color
pdr_color_nh = [0.1 0.5 0.3]; %  [0.2 0.1 0.2]
pdr_color_vh = [0.8500 0.3250 0.0980]; % orange color

% Define the marker face colors
pdrsh_marker_color = [0.2 0.4 0.6]; % light blue color
pdrnh_marker_color = [0.1 0.5 0.3]; % light blue color
pdrvh_marker_color = [0.8500 0.3250 0.0980]; % yellow color



figure(1)

box on;
hold on;
plt=plot(node,pdrsh,'x-', 'Color', pdr_color_sh, 'LineWidth', 1, 'MarkerFaceColor', pdrsh_marker_color);
hold on
plt=plot(node,pdrnh,'o-', 'Color', pdr_color_nh, 'LineWidth', 1, 'MarkerFaceColor', pdrnh_marker_color,'MarkerSize',3);
hold on
plt=plot(node,pdrvh,'o-', 'Color', pdr_color_vh, 'LineWidth', 1, 'MarkerFaceColor', pdrvh_marker_color,'MarkerSize',4);



% setting the axis
xlim([50 500])
xticks([50 100 150 200 250 300 350 400 450 500]);
xticklabels({'50','100','150','200','250','300', '350','400','450','500'});
ylim([0.1,1]);
yticks([0.2 0.4 0.6 0.8 1]);
yticklabels({'0.2','0.4','0.6','0.8','1'});


% Axis and legend setup
xlabel('Number of Nodes','FontName','Arial','fontsize',14);
ylabel('Packet Delivery Ratio','FontName','Arial','fontsize',14);
grid on;
box on;
legend({'SH','NRH','VH'},'Location','northeast');
legend boxon;

% Removing tick to make it look more profession
set(gca, 'Ticklength', [0 0])

% Customizing texts in the axis in ticklabel, making the background white
set(gcf,'color','w');    
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'FontName','Arial','fontsize',10);
b = get(gca,'YTickLabel');
set(gca,'YTickLabel',b,'FontName','Arial','fontsize',10);

% Fixing the aspect ratio
pbaspect([8,6,1])
