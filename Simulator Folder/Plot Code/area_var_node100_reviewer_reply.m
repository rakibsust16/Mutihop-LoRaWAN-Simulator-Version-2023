
area=[3 3.67 5 7 9 11]



pdr3=[0.87949 0.56858 0.65883 0.78038 0.56067 0.50721 0.72618];
pdr367=[0.87924 0.59491 0.67119 0.79553 0.56161 0.5623 0.67233];
pdr5=[0.58255 0.62161 0.631 0.82227 0.60504 0.58292 0.52439];
pdr7=[0.35538 0.65003 0.21562 0.51723 0.6475 0.54087 0.50034];
pdr9=[0.20203 0.11901 0.18247 0.31375 0.67701 0.49003 0.48576];
pdr11=[0.17755 0.1134 0.10247 0.16844 0.46001 0.41605 0.39345];

pdrsh=[pdr3(1) pdr367(1) pdr5(1) pdr7(1) pdr9(1) pdr11(1)];
pdrnh=[pdr3(5) pdr367(5) pdr5(5) pdr7(5) pdr9(5) pdr11(5)];
pdrvh=[pdr3(4) pdr367(4) pdr5(4) pdr7(4) pdr9(4) pdr11(4)];%122


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
plot(area,pdrsh, 'x-', 'Color', proposed_color_sh, 'LineWidth', 1, 'MarkerFaceColor', proposedsh_marker_color);
hold on
plot(area,pdrnh, 'o-', 'Color', proposed_color_nh, 'LineWidth', 1, 'MarkerFaceColor', proposednh_marker_color,'MarkerSize',3);
hold on
plot(area,pdrvh, 'o-', 'Color', proposed_color_vh, 'LineWidth', 1, 'MarkerFaceColor', proposedvh_marker_color,'MarkerSize',4);

% setting the axis
xlim([3 11])
xticks([3 4 5 6 7 8 9 10 11 12]);
xticklabels({'3','4','5','6', '7','8','9','10','11','12'});
ylim([0.1,1]);
yticks([0.1 0.3 0.5 0.7 0.9 1]);
yticklabels({'0.1','0.3','0.5','0.7','0.9','1'});

% Axis and legend setup
xlabel('Area Radius (km)','FontName','Arial','fontsize',14);
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




epn3=[0.0017724 0.00018371 0.000279 0.00065069 0.00011795 0.00039158 0.0012858];
epn367=[0.0031397 0.00034505 0.00044209 0.0012057 0.00014586 0.00069365 0.0019682];
epn5=[0.0063864 0.00081922 0.00087059 0.0034422 0.0003037 0.0014433 0.0036541];
epn7=[0.0086627 0.0023816 0.0023097 0.007629 0.0008067 0.0038532 0.0043431];
epn9=[0.010354 0.00415 0.0039597 0.0095514 0.0018364 0.0048097 0.0055638];
epn11=[0.010519 0.0053999 0.0056685 0.010821 0.0032219 0.006519 0.0074479];

epnsh=[epn3(1) epn367(1) epn5(1) epn7(1) epn9(1) epn11(1)];
epnnh=[epn3(5) epn367(5) epn5(5) epn7(5) epn9(5) epn11(1)];
epnvh=[epn3(4) epn367(4) epn5(4) epn7(4) epn9(4) epn11(4)];

figure(2)

box on;
hold on;

plot(area,epnsh, 'x-', 'Color', proposed_color_sh, 'LineWidth', 1, 'MarkerFaceColor', proposedsh_marker_color);
hold on
plot(area,epnnh, 'o-', 'Color', proposed_color_nh, 'LineWidth', 1, 'MarkerFaceColor', proposednh_marker_color,'MarkerSize',3);
hold on
plot(area,epnvh, 'o-', 'Color', proposed_color_vh, 'LineWidth', 1, 'MarkerFaceColor', proposedvh_marker_color,'MarkerSize',4);

% setting the axis
xlim([3 11])
xticks([3 4 5 6 7 8 9 10 11 12]);
xticklabels({'3','4','5','6', '7','8','9','10','11','12'});
y_min = min([epnsh epnnh epnvh]);
y_max = max([epnsh epnnh epnvh]);
ylim([y_min 0.013]);

yticks([0.001 0.003 0.005 0.007 0.0090 0.011 0.013]);
yticklabels({'0.001', '0.003','0.005','0.007','0.009','0.011','0.013'});



% Axis and legend setup
xlabel('Area Radius (km)','FontName','Arial','fontsize',14);
ylabel('Energy Consumption of Node (%)','FontName','Arial','fontsize',14)
grid on;
box on;
legend({'SH','NRH','VH'},'Location','northwest');
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


figure(3)
X = categorical([ "3","5", "7","9","11"]);
X = reordercats(X,cellstr(X)');
% pdr=[pdr3(1) pdr3(2) pdr3(4);pdr5(1) pdr5(2) pdr5(4);pdr7(1) pdr7(2) pdr7(5); pdr9(1) pdr9(2) pdr9(5);pdr11(1) pdr11(2) pdr11(5)];
pdr=[pdr3(1) pdr3(2) pdr3(4);pdr5(1) pdr5(2) pdr5(4);pdr7(1) pdr7(2) pdr7(5); pdr9(1) pdr9(2) pdr9(5);pdr11(1) pdr11(2) pdr11(5)];
F1=bar(X,pdr,'FaceColor','flat');
F1(1).FaceColor = [.2 .1 .2];
F1(2).FaceColor = [.2 .6 .5];
F1(3).FaceColor = [.2 .3 .2];
% F1(4).FaceColor = [.1 .2 .3];


xlabel('Area Radius (km)','FontName','Arial','fontsize',14);
ylabel('Packet Delivery Ratio','FontName','Arial','fontsize',14)
grid on;
box on;
legend({'1 ring','2 ring','3 ring'},'Location','northeast');
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



figure(4)
X = categorical([ "3","5", "7","9","11"]);
X = reordercats(X,cellstr(X)');
% epng=[epn3(1) epn3(2) epn3(4);epn5(1) epn5(2) epn5(4);epn7(1) epn7(2) epn7(5); epn9(1) epn9(2) epn9(5);epn11(1) epn11(2) epn11(5)];
epng=[epn3(1) epn3(2) epn3(4);epn5(1) epn5(2) epn5(4);epn7(1) epn7(2) epn7(5); epn9(1) epn9(2) epn9(5);epn11(1) epn11(2) epn11(5)];
F1=bar(X,epng,'FaceColor','flat');
F1(1).FaceColor = [.2 .1 .2];
F1(2).FaceColor = [.2 .6 .5];
F1(3).FaceColor = [.2 .3 .2];
% F1(4).FaceColor = [.1 .2 .3];


xlabel('Area Radius (km)','FontName','Arial','fontsize',14);
ylabel('Energy Consumption of Node (%)','FontName','Arial','fontsize',14)
grid on;
box on;
legend({'1 ring','2 ring','3 ring'},'Location','northwest');
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





%% previous code


% 
% area=[3 3.67 5 7 9 11]
% 
% 
% 
% pdr3=[0.87949 0.56858 0.65883 0.78038 0.56067 0.50721 0.72618];
% pdr367=[0.87924 0.59491 0.67119 0.79553 0.56161 0.5623 0.67233];
% pdr5=[0.58255 0.62161 0.631 0.82227 0.60504 0.58292 0.52439];
% pdr7=[0.35538 0.65003 0.21562 0.51723 0.6475 0.54087 0.50034];
% pdr9=[0.20203 0.11901 0.18247 0.31375 0.67701 0.49003 0.48576];
% pdr11=[0.17755 0.1134 0.10247 0.16844 0.46001 0.41605 0.39345];
% 
% pdrsh=[pdr3(1) pdr367(1) pdr5(1) pdr7(1) pdr9(1) pdr11(1)];
% pdrnh=[pdr3(5) pdr367(5) pdr5(5) pdr7(5) pdr9(5) pdr11(5)];
% pdrvh=[pdr3(4) pdr367(4) pdr5(4) pdr7(4) pdr9(4) pdr11(4)];%122
% 
% 
% % Define the line colors
% proposed_color_sh = [0.2 0.4 0.6]; % blue color
% proposed_color_nh = [0.4 0.1 0.2]; %  [0.2 0.1 0.2]
% proposed_color_vh = [0.8500 0.3250 0.0980]; % orange color
% 
% % Define the marker face colors
% proposedsh_marker_color = [0.2 0.4 0.6]; % light blue color
% proposednh_marker_color = [0.4 0.1 0.2]; % light blue color
% proposedvh_marker_color = [0.8500 0.3250 0.0980]; % yellow color
% 
% 
% figure(1)
% 
% box on;
% hold on;
% plot(area,pdrsh, 'x-', 'Color', proposed_color_sh, 'LineWidth', 1.1, 'MarkerFaceColor', proposedsh_marker_color);
% hold on
% plot(area,pdrnh, '*-', 'Color', proposed_color_nh, 'LineWidth', 1.1, 'MarkerFaceColor', proposednh_marker_color);
% hold on
% plot(area,pdrvh, '^-', 'Color', proposed_color_vh, 'LineWidth', 1.1, 'MarkerFaceColor', proposedvh_marker_color);
% 
% % setting the axis
% xlim([3 11])
% xticks([1 2 3 4 5 6 7 8 9 10 11 12]);
% xticklabels({'1','2','3','4','5','6', '7','8','9','10','11','12'});
% ylim([0.1,1]);
% yticks([0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]);
% yticklabels({'0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'});
% 
% % Axis and legend setup
% xlabel('Area Radius (km)','FontName','Arial','fontsize',14);
% ylabel('Packet Delivery Ratio','FontName','Arial','fontsize',14);
% grid on;
% box on;
% legend({'SH','NRH','VH'},'Location','northeast');
% legend boxon;
% 
% % Removing tick to make it look more profession
% set(gca, 'Ticklength', [0 0])
% 
% % Customizing texts in the axis in ticklabel, making the background white
% set(gcf,'color','w');    
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Arial','fontsize',10);
% b = get(gca,'YTickLabel');
% set(gca,'YTickLabel',b,'FontName','Arial','fontsize',10);
% 
% % Fixing the aspect ratio
% pbaspect([8,6,1])
% 
% 
% 
% 
% epn3=[0.0017724 0.00018371 0.000279 0.00065069 0.00011795 0.00039158 0.0012858];
% epn367=[0.0031397 0.00034505 0.00044209 0.0012057 0.00014586 0.00069365 0.0019682];
% epn5=[0.0063864 0.00081922 0.00087059 0.0034422 0.0003037 0.0014433 0.0036541];
% epn7=[0.0086627 0.0023816 0.0023097 0.007629 0.0008067 0.0038532 0.0043431];
% epn9=[0.010354 0.00415 0.0039597 0.0095514 0.0018364 0.0048097 0.0055638];
% epn11=[0.010519 0.0053999 0.0056685 0.010821 0.0032219 0.006519 0.0074479];
% 
% epnsh=[epn3(1) epn367(1) epn5(1) epn7(1) epn9(1) epn11(1)];
% epnnh=[epn3(5) epn367(5) epn5(5) epn7(5) epn9(5) epn11(1)];
% epnvh=[epn3(4) epn367(4) epn5(4) epn7(4) epn9(4) epn11(4)];
% 
% figure(2)
% 
% box on;
% hold on;
% 
% plot(area,epnsh, 'x-', 'Color', proposed_color_sh, 'LineWidth', 1.1, 'MarkerFaceColor', proposedsh_marker_color);
% hold on
% plot(area,epnnh, '*-', 'Color', proposed_color_nh, 'LineWidth', 1.1, 'MarkerFaceColor', proposednh_marker_color);
% hold on
% plot(area,epnvh, '^-', 'Color', proposed_color_vh, 'LineWidth', 1.1, 'MarkerFaceColor', proposedvh_marker_color);
% 
% % setting the axis
% xlim([3 11])
% xticks([1 2 3 4 5 6 7 8 9 10 11 12]);
% xticklabels({'1','2','3','4','5','6', '7','8','9','10','11','12'});
% y_min = min([epnsh epnnh epnvh]);
% y_max = max([epnsh epnnh epnvh]);
% ylim([y_min 0.013]);
% yticks(0:0.001:0.013);
% yticks([0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.011 0.012 0.013]);
% yticklabels({'0.001', '0.002', '0.003', '0.004', '0.005', '0.006', '0.007', '0.008', '0.009', '0.01', '0.011','0.012','0.013'});
% 
% 
% 
% % Axis and legend setup
% xlabel('Area Radius (km)','FontName','Arial','fontsize',14);
% ylabel('Energy Consumption of Node (%)','FontName','Arial','fontsize',14)
% grid on;
% box on;
% legend({'SH','NRH','VH'},'Location','northwest');
% legend boxon;
% 
% % Removing tick to make it look more profession
% set(gca, 'Ticklength', [0 0])
% 
% % Customizing texts in the axis in ticklabel, making the background white
% set(gcf,'color','w');    
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'FontName','Arial','fontsize',10);
% b = get(gca,'YTickLabel');
% set(gca,'YTickLabel',b,'FontName','Arial','fontsize',10);
% 
% % Fixing the aspect ratio
% pbaspect([8,6,1])









