
% Initialize the random number generator
rng(0)

% Define the nodes
nodes = [50 100 200 300 400 500];
node=[nodes(2) nodes(4)];
pdr50=[0.9397 0.70803 0.7919 0.82981 0.67945 0.71657 0.81245];
pdr100=[0.87949 0.56858 0.65883 0.78038 0.56067 0.50721 0.72618];
pdr200=[0.73878 0.42419 0.43842 0.61694 0.41108 0.31637 0.55147];
pdr300=[0.63551 0.30111 0.34903 0.48105 0.30291 0.23258 0.44474];
pdr400=[0.549640052398524 0.25543582777837 0.290395267525617 0.396757041596522 0.224633026372247 0.173713970897318 0.392775729921225];
pdr500=[0.47332 0.2063 0.22954 0.35024 0.18841 0.14016 0.32847];


pdrsh=[pdr100(1) pdr300(1)];
% pdrnh=[pdr100(5) pdr300(5)];
pdrmh=[pdr100(4) pdr300(4)];%122

% Define the proposed energy values

txenr_sh_in_mj=[48.512 94.887 197.62 324.15 426.119 543.15]*1000;
txenr_mh_in_mj=[24.261 46.907 96.34 144.32 192.4 242.81]*1000;

sentpackets_sh=[754.83 1487.1 3049.6 4523.4 6042.6 7797.4];
sentpackets_mh=[957.33 2002.4 4046 6086.4 8238.2 9910];

enr_sh_proposed=(txenr_sh_in_mj)./(sentpackets_sh)
enr_mh_proposed=(txenr_mh_in_mj)./(sentpackets_mh)

enr_sh=[enr_sh_proposed(2) enr_sh_proposed(4)];
enr_mh=[enr_mh_proposed(2) enr_mh_proposed(4)];



% proposed_color_sh = [0.2 0.4 0.6]; % blue color
% proposed_color_mh = [0.4 0.1 0.2]; % blue color  [0.2 0.1 0.2]
% % [0.8500 0.3250 0.0980]; % orange color
% 
% % Define the marker face colors
% proposedsh_marker_color = [0.2 0.4 0.6]; % light blue color
% proposedmh_marker_color = [0.4 0.1 0.2]; % light blue color
% % [0.8500 0.3250 0.0980]; % yellow color

figure(1)
X = categorical([ "Sparse", "Dense"]);
X = reordercats(X,cellstr(X)');
pdr=[pdrsh(1) pdrmh(1);pdrsh(2) pdrmh(2)];
F1=bar(X,pdr,'FaceColor','flat');
F1(1).FaceColor = [.2 .1 .2];
F1(2).FaceColor = [.2 .6 .5];

% setting the axis
ylim([0.3,1]);
yticks([0.4 0.5 0.6 0.7 0.8 0.9 1]);
yticklabels({'0.4','0.5','0.6','0.7','0.8','0.9','1'});


% Axis and legend setup
xlabel('Deployment Type','FontName','Arial','fontsize',14);
ylabel('Packet Delivery Ratio','FontName','Arial','fontsize',14);
grid on;
box on;
legend ('Single-hop','Multi-hop','location','northeast');
legend boxon;

% Removing tick to make it look more profession
set(gca, 'Ticklength', [0 0])

% Customizing texts in the axis in ticklabel, making the background white
set(gcf,'color','w');    
b = get(gca,'YTickLabel');
set(gca,'YTickLabel',b,'FontName','Arial','fontsize',10);

% Fixing the aspect ratio
pbaspect([8,6,1])


figure(2)
X = categorical([ "Sparse", "Dense"]);
X = reordercats(X,cellstr(X)');
enr=[enr_sh(1) enr_mh(1);enr_sh(2) enr_mh(2)];
F1=bar(X,enr,'FaceColor','flat');
F1(1).FaceColor = [.2 .1 .2];
F1(2).FaceColor = [.2 .6 .5];

% setting the axis
ylim([0, 100]);
yticks([10 20 30 40 50 60 70 80 90 100]);
yticklabels({'10','20','30','40','50','60','70','80','90','100'});


% Axis and legend setup
xlabel('Deployment Type','FontName','Arial','fontsize',14);
ylabel('Energy Consumption (mJ)','FontName','Arial','fontsize',14);
grid on;
box on;
legend ('Single-hop','Multi-hop','location','northeast');
legend boxon;

% Removing tick to make it look more profession
set(gca, 'Ticklength', [0 0])

% Customizing texts in the axis in ticklabel, making the background white
set(gcf,'color','w');    
b = get(gca,'YTickLabel');
set(gca,'YTickLabel',b,'FontName','Arial','fontsize',10);

% Fixing the aspect ratio
pbaspect([8,6,1])









