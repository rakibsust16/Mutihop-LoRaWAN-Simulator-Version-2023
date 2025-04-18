
clc
clear all

TH=[2 4 6 8 10];





pdr2=[0.12708 0.14109 0.3398 0.86562 0.62579 0.60265];
pdr4=[0.21573 0.11515 0.33555 0.80847 0.61221 0.56659];
pdr6=[0.18091 0.21685 0.26456 0.62367 0.61186 0.4959];
pdr8=[0.20998 0.22063 0.34936 0.47771 0.59571 0.3555];
pdr10=[0.17853 0.22625 0.37001 0.47777 0.52508 0.41957];
% pdrsh=[pdr3(1) pdr5(1) pdr7(1) pdr9(1) pdr11(1)];

pdrnh=[pdr2(4) pdr4(4) pdr6(4) pdr8(4) pdr10(4)];
pdrvh=[pdr2(5) pdr4(5) pdr6(5) pdr8(5) pdr10(5)];%5 indicates 112


% Define the line colors

proposed_color_nh = [0.1 0.5 0.3]; %  [0.2 0.1 0.2]
proposed_color_vh = [0.8500 0.3250 0.0980]; % orange color

% Define the marker face colors

proposednh_marker_color = [0.1 0.5 0.3]; % light blue color
proposedvh_marker_color = [0.8500 0.3250 0.0980]; % yellow color





figure(1)

box on;

hold on
plot(TH,pdrnh, '^-', 'Color', proposed_color_nh, 'LineWidth', 1, 'MarkerFaceColor', proposednh_marker_color,'MarkerSize',4);
hold on
plot(TH,pdrvh, '^-', 'Color', proposed_color_vh, 'LineWidth', 1, 'MarkerFaceColor', proposedvh_marker_color,'MarkerSize',4);


% setting the axis
xlim([2 10])
xticks([2 3 4 5 6 7 8 9 10 11 12]);
xticklabels({'2','3','4','5','6', '7','8','9','10','11','12'});
ylim([0.1,0.9]);
yticks([0.1 0.3 0.5 0.7 0.9 1]);
yticklabels({'0.1','0.3','0.5','0.7','0.9','1'});

% Axis and legend setup
xlabel('Number of Nodes Under an IG','FontName','Arial','fontsize',14);
ylabel('Packet Delivery Ratio','FontName','Arial','fontsize',14);
grid on;
box on;
legend({'NRH','VH'},'Location','northeast');
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




time=repelem(600,1,6);
f2=[509.4 504.8 49.6 1179.6 353.6 296];
ig2=[19.4 14.2 14.2  29.2 22.6 8.8];
pfr2=(f2./(time .* ig2))
f4=[539.6 533.2 348.6 698.2 555.2 492];
ig4=[9.4 7.2 7.4 13 11.6 5];
pfr4=(f4./(time .* ig4))
f6=[537 490.4 332 622.2 533 439.6];
ig6=[6.8 4.8 5.2 9.2 8.2 3];
pfr6=(f6./(time .* ig6))
f8=[517.2 465.6 355.8 495.4 482.4 371.8];
ig8=[5.4 3.8 3.6 6.6 6.6 2.2];
pfr8=(f8./(time .* ig8))
f10=[459.2 456.4 370 569.4 465 425.8];
ig10=[4 3.4 3.2 5.6 5.4 2.2];
pfr10=(f10./(time .* ig10))


pfrnh=[pfr2(4) pfr4(4) pfr6(4) pfr8(4) pfr10(4)];
pfrvh=[pfr2(5) pfr4(5) pfr6(5) pfr8(5) pfr10(5)];


figure(2)

box on;

hold on
plot(TH,pfrnh, '^-', 'Color', proposed_color_nh, 'LineWidth', 1, 'MarkerFaceColor', proposednh_marker_color,'MarkerSize',4);
hold on
plot(TH,pfrvh, '^-', 'Color', proposed_color_vh, 'LineWidth', 1, 'MarkerFaceColor', proposedvh_marker_color,'MarkerSize',4);


% setting the axis
xlim([2 10])
xticks([2 3 4 5 6 7 8 9 10 11 12]);
xticklabels({'2','3','4','5','6', '7','8','9','10','11','12'});
ylim([0,0.2]);
yticks([0 0.1 0.2 0.3 0.4 0.5]);
yticklabels({'0','0.1','0.2','0.3','0.4','0.5'});

% Axis and legend setup
xlabel('Number of Nodes Under an IG','FontName','Arial','fontsize',14);
ylabel('Packet Forwarding Rate','FontName','Arial','fontsize',14);
grid on;
box on;
legend({'NRH','VH'},'Location','northeast');
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

%number of ig


ignh=round([ig2(4) ig4(4) ig6(4) ig8(4) ig10(4)])
igvh=round([ig2(5) ig4(5) ig6(5) ig8(5) ig10(5)])

figure(4)


box on;

hold on
plot(TH,ignh, '^-', 'Color', proposed_color_nh, 'LineWidth', 1, 'MarkerFaceColor', proposednh_marker_color,'MarkerSize',4);
hold on
plot(TH,igvh, '^-', 'Color', proposed_color_vh, 'LineWidth', 1, 'MarkerFaceColor', proposedvh_marker_color,'MarkerSize',4);


% setting the axis
xlim([2 10])
xticks([2 3 4 5 6 7 8 9 10 11 12]);
xticklabels({'2','3','4','5','6', '7','8','9','10','11','12'});
ylim([5,30]);
yticks([5 10 15 20 25 30]);
yticklabels({'5','10','15','20','25','30'});

% Axis and legend setup
xlabel('Number of Nodes Under an IG','FontName','Arial','fontsize',14);
ylabel('Number of IGs','FontName','Arial','fontsize',14);
grid on;
box on;
legend({'NRH','VH'},'Location','northeast');
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







