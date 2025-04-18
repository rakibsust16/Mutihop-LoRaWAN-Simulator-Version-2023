DC=[1 3 5 7 9];

% shp=[0.95 0.67 0.25];

figure(1)
pdr1=[0.84953 0.36406 0.53238 0.62851 0.40644 0.22088 0.61809];
pdr3=[0.8369 0.36026 0.53136 0.61813 0.40427 0.22038 0.60494];
pdr5=[0.83315 0.36618 0.5237 0.61108 0.40236 0.22675 0.62408];
pdr7=[0.83281 0.35505 0.51571 0.6086 0.38054 0.22606 0.59648];
pdr9=[0.80083 0.34962 0.47997 0.6057 0.35851 0.2177 0.5771];
shp=[pdr1(1) pdr3(1) pdr5(1) pdr7(1) pdr9(1)];
nhp=[pdr1(5) pdr3(5) pdr5(5) pdr7(5) pdr9(5)];
vhp=[pdr1(4) pdr3(4) pdr5(4) pdr7(4) pdr9(4)];      



% Define the line colors
proposed_color_sh = [0.2 0.4 0.6]; % blue color
proposed_color_nh = [0.1 0.5 0.3]; %  [0.2 0.1 0.2]
proposed_color_vh = [0.8500 0.3250 0.0980]; % orange color

% Define the marker face colors
proposedsh_marker_color = [0.2 0.4 0.6]; % light blue color
proposednh_marker_color = [0.1 0.5 0.3]; % light blue color
proposedvh_marker_color = [0.8500 0.3250 0.0980]; % yellow color


figure(1)

box on;
hold on;
plot(DC,shp, 'x-', 'Color', proposed_color_sh, 'LineWidth', 1, 'MarkerFaceColor', proposedsh_marker_color);
hold on
plot(DC,nhp, 'o-', 'Color', proposed_color_nh, 'LineWidth', 1, 'MarkerFaceColor', proposednh_marker_color,'MarkerSize',3);
hold on
plot(DC,vhp, 'o-', 'Color', proposed_color_vh, 'LineWidth', 1, 'MarkerFaceColor', proposedvh_marker_color,'MarkerSize',4);


% setting the axis
xlim([1 9])
xticks([1 2 3 4 5 6 7 8 9 10 11 12]);
xticklabels({'1','2','3','4','5','6', '7','8','9','10','11','12'});
ylim([0.3,1]);
yticks([0.1 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]);
yticklabels({'0.1','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'});


% Axis and legend setup
xlabel('Duty Cycle (%)','FontName','Arial','fontsize',14);
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