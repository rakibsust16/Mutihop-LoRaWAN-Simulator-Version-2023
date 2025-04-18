% *Multihop LoRaWAN Simulator 2023* [Developed by Md. Rakibul Islam and Bokhtiar-Al-Zami]
% Published Paper on this simulator for citation - 

%   @ARTICLE{10130532,
%   author={Rakibul Islam, Md. and Bokhtiar-Al-Zami, Md. and Paul, Biswajit and Palit, Rajesh and Grégoire, Jean-Charles and Islam, Salekul},
%   journal={IEEE Access}, 
%   title={Performance Evaluation of Multi-Hop LoRaWAN}, 
%   year={2023},
%   volume={11},
%   number={},
%   pages={50929-50945},
%   keywords={Spread spectrum communication;Logic gates;Mathematical models;Energy consumption;Relays;Interference;Sensors;Energy efficiency;Energy efficiency;interference;LoRaWAN;packet delivery rate;routing},
%   doi={10.1109/ACCESS.2023.3278687}}

clc
clear all
%% Network Design Parameters or inputs
iteration =5;
node=10;
areadef=[3];
dcycle=[1];
input_NF=6;
chset = randi([867,872],1,node);
channel_number=length(unique(chset));
input_BW=125000;
input_preamble_length=8;
input_B_UL=20;%payload
input_H=1;
DE=0;
input_CR=1;
start_t=1;
end_t=600;
time = randi([start_t,60],1,node);
operating_frequency=868;
operating_voltage=3;
battery=3600; %1000mAh = 1Ah = 1 A* 3600 sec
Total_e_battery= operating_voltage*battery; % It is in joule

%% Initiate key variables
packet_delivery_rate=[];
PDR = [];
P_DR =[];
ndinfo=[];
send=[];
send1=[];
recsen=[];
pfig=[];
energynode=[];
energycon=[];
gwstore=[];
energyar=[];
threshold=6;
forwardn=[];
inddatasave=[];
epn=[];
epnp=[];
potentialrelay=[];
% e_consumption_per_node = [];
% percentage_e_consumption_of_node = [];

%%
for pathvar=4 %This variable declares the routing strategy
for nr=1:length(areadef) 

areav=areadef(nr);
TH=threshold;
dutycycle=dcycle;
Ps= [];
igcount=[];
sss=[];
sssstore=[];
rrr=[];
rrrstore=[];
rrrini=[];
total_energy=[];
tntx=[];
tigtx=[];
trtx=[];
relaypotig=0;
relayig=[];
relaybyig=[];


for it= [1:iteration]


format short g

if pathvar==1
path =[1];
number_of_rings= length(path);
end
if pathvar==2
path =[1 1];
number_of_rings= length(path);
end
if pathvar==3
path =[1 2 1];
number_of_rings= length(path);
end
if pathvar==4
path =[1 2 2];
number_of_rings= length(path);
end
if pathvar==5
path =[1 1 1];
number_of_rings= length(path);
end
if pathvar==6
path =[1 1 2];
number_of_rings= length(path);
end
if pathvar==7
path =[1 1 3];
number_of_rings= length(path);
end
if pathvar==8
path =[1 1 1 1];
number_of_rings= length(path);
end

aa=-areav;
bb=areav;
Max_radius=areav;

% x_r and y_r are two arrays that contain the combination of x and y for
% which the node falls inside a circle

x_r=[];
y_r=[];
D_R=[];
x_s=[];
y_s=[];
s=1;
overall_pro_1=[];
ov=[];
ov1=[];

while s<=node
x=aa+(bb-aa)*rand(1,1);  % x co-ordinate
y=aa+(bb-aa)*rand(1,1);  %y co-ordinate

distance=sqrt(x^2+y^2); % Distance from the center (0,0) where the GW is located

if distance>Max_radius % Discards a node that falls outside the circle; otherwise keeps it
s=s;
else
x_r(s)=x;
y_r(s)=y;
D_R=(sqrt(x_r.^2+y_r.^2));
r=x_r+1i*y_r;
s=s+1;
end
end
d_r=sort(D_R);


for i=1:node
for j=1:node
if (d_r(i)==D_R(j))
x_s(i)=x_r(j);
y_s(i)=y_r(j);
end
end
end
x_s;
y_s;

radius_of_ring=Max_radius/number_of_rings;
Fibonacci_sequence_length=20;
fib=zeros(1,Fibonacci_sequence_length);
fib(1)=1;
fib(2)=1;
k=3;
while k <= Fibonacci_sequence_length
fib(k)=fib(k-2)+fib(k-1);
k=k+1;
end

fib;
ring_distances=[];
ring_distances(1)=0;

for i=1:number_of_rings

ring_distances(i+1)=(fib(i+1)*Max_radius)/fib(number_of_rings+1);
end

ring_distances;

r_d=[];
for i=1:number_of_rings
r_d(i)=(fib(i+1)*Max_radius)/fib(number_of_rings+1);
end
r_d;

% calculation of nodes inside different rings
distance_from_nodes=d_r;
radius_of_ring1=Max_radius/number_of_rings;

for m=1:number_of_rings

final_count=0;
count=1;

while count<=node
if distance_from_nodes(count)<=ring_distances(m+1)
final_count=final_count+1;
else
final_count=final_count;
end
count=count+1;
end

node_distribution(m)=final_count;
end

node_distribution;

% Node distribution in the region between consecutive rings

node_distribution_between_consecutive_rings=[];
node_distribution_between_consecutive_rings(1)=node_distribution(1);

for j=2:number_of_rings
node_distribution_between_consecutive_rings(j)= node_distribution(j)-node_distribution(j-1);
end
nd=node_distribution_between_consecutive_rings;

ringnodes=[];
ringnodes=nd;
n=sum(ringnodes);
cn=[];
p=path;
xx=[];
yy=[];
zz=[];
Rmat=zeros(length(path),length(path));
for i=1:length(path)
for j=1:length(path)
if i<j && i==j-p(j)
Rmat(i,j)=1;
end
end
end

cn=[];
for j=1:length(path)
if nd(j)==1
cn(j)=1;
elseif nd(j)<TH && nd(j)~=0
cn(j)=nd(j);
elseif nd(j)==0
cn(j)=1;
else
cn(j)=TH;
end
end

ig1=[];

for i=1:length(path)
ign=[];
for j=1:length(path)
if Rmat(i,j)==1

igc= ceil(Rmat(i,j)*((nd(j))/cn(j)));
ign=[ign igc];

end

end
ig1(i)=sum(ign);
end
ig1;

%%
ig=[];

for i=length(path):-1:1
ignu=[];
for j=length(path):-1:1
if Rmat(i,j)==1
igu=Rmat(i,j)*(ceil((nd(j)+ig1(j))/cn(j)));
ignu=[ignu igu];
end
end
ig(i)=sum(ignu);
end
ig;

if sum(ig)>0
chsig=randi([867,872],1,sum(ig));
end

if sum(ig)>0
angle=[];
degree_ig=[];

for j=1:length(ig)
if ig(j)==0
continue;

else
interval=(2*pi)/ig(j);
for i=1:ig(j)
if i==1
theta=0;
angle=[angle theta];
degree_ig=[degree_ig rad2deg(theta)] ;
else
theta=theta+interval;
angle=[angle theta];
degree_ig=[degree_ig rad2deg(theta)] ;
end
end
angle;
degree_ig;
end
end

rho = repelem(r_d,ig);
[xig,yig] = pol2cart(angle,rho);

xxig=xig;
yyig=yig;

%% plot
%% 
[theta_nd,rho_nd] = cart2pol(x_s,y_s);
degree_nd = rad2deg( theta_nd );
igtomgdist=sort((sqrt(xxig.^2+yyig.^2)));

%%

nig=zeros(node,sum(ig));
rig=zeros(node,sum(ig));
rigu=zeros(node,sum(ig));
nig2=zeros(node,sum(ig));
%HOP 1
for i=1:length(path)
for j=1:length(path)
if Rmat(i,j)==1
igs=0;
nds=0;
for k=2:i
igs=igs+ig(k-1);
end
for g=1:j-1
nds=nds+nd(g);
end

for v=igs+1:igs+ig(i)
for u=nds+1:nds+nd(j)
x_nig = x_s(u)-xig(v);
y_nig = y_s(u)-yig(v);
d_nig = (x_nig^2+y_nig^2)^(1/2);
nig(u,v)=d_nig;


end
end
end

end
end

Anan=nig;
Anan(nig == 0) = NaN;
[M,I] = min(Anan,[],2,'linear');
MR = M.';
ini=1;
MRU=[];

for i=1:length(path)
if nd(i)==0
continue
else
if i==1
for j=ini:nd(i)
MRU(j)=d_r(j);
end
else

flag=0;

for k=1:i
if Rmat(k,i)==1
for j=ini:ini+nd(i)-1
MRU(j)=MR(j);
flag=1;
end
elseif Rmat(k,i)==0 && flag==0 && k<i
for j=ini:ini+nd(i)-1
MRU(j)=d_r(j);
end
else
continue
end
end
end
ini=ini+nd(i);
end
end

rr=MRU;
rrcheck=[d_r(1,1:nd(1)) rmmissing(MR)];

else
rr=d_r;
end

for i=1:node
for j=1:sum(ig)
if MR(i)==nig(i,j)
rig(i,j)=1;
rigu(i,j)=j;
end
end
end

rigum=zeros(node,sum(ig)+1);
for i=1:node
for j=1:(sum(ig)+1)
if j< (sum(ig)+1)
if rig(i,j)==1
rigum(i,j)=rigu(i,j);
rigum(i,sum(ig)+1)=0;
break
else
rigum(i,sum(ig)+1)=sum(ig)+1;
end
end
end
end
%%
%IG assigned to Node
assig=zeros(node,1);
for assi=1:node
for assj=1:sum(ig)+1
if rigum(assi,assj)~=0
assig(assi,1)=rigum(assi,assj);
end
end
end
assig=assig';
%%
nodeigr=zeros(node,length(path));

%%
%
if sum(ig)>0
igtig=zeros(sum(ig),sum(ig));
for i=1:length(path)-1
for j=1:length(path)-1
if Rmat(i,j)==1
igs=0;
nds=0;
for k=2:i
igs=igs+ig(k-1);
end
for g=1:j-1
nds=nds+ig(g);
end

for v=igs+1:igs+ig(i)
for u=nds+1:nds+ig(j)
x_nig = xig(u)-xig(v);
y_nig = yig(u)-yig(v);
d_nig = (x_nig^2+y_nig^2)^(1/2);
igtig(u,v)=d_nig;
end
end
end

end
end



Ananig=igtig;
Ananig(igtig == 0) = NaN;
[Mig,I] = min(Ananig,[],2,'linear');
MRig = Mig.';
ini=1;
MRUig=[];

for i=1:length(path)-1
if ig(i)==0
continue
else
if i==1
for j=ini:ig(i)
MRUig(j)=igtomgdist(j);
end
else


flag=0;


for k=1:i
if Rmat(k,i)==1
for j=ini:ini+ig(i)-1
MRUig(j)=MRig(j);
flag=1;
end
elseif Rmat(k,i)==0 && flag==0 && k<i
for j=ini:ini+ig(i)-1
MRUig(j)=igtomgdist(j);
end
else
continue
end
end
end
ini=ini+ig(i);
end
end

rrig=MRUig;
rrcheckig=[igtomgdist(1,1:ig(1)) rmmissing(MR)];

else
end

%%
%IG TO IG Relation Matrix
rigtigu=zeros(sum(ig),sum(ig));
rigtig=zeros(sum(ig),sum(ig));

for i=1:sum(ig)
for j=1:sum(ig)
if MRig(i)==igtig(i,j)
rigtig(i,j)=1;
rigtigu(i,j)=j;
end
end
end

rigtigum=zeros(sum(ig),sum(ig)+1);
for i=1:sum(ig)
for j=1:(sum(ig)+1)
if j< (sum(ig)+1)
if rigtig(i,j)==1
rigtigum(i,j)=rigtigu(i,j);
rigtigum(i,sum(ig)+1)=0;
break
else
rigtigum(i,sum(ig)+1)=sum(ig)+1;
end
end
end
end

%%
%IG assigned to other IGs
assigtig=zeros(sum(ig),1);
for assigi=1:sum(ig)
for assigj=1:sum(ig)+1
if rigtigum(assigi,assigj)~=0
assigtig(assigi,1)=rigtigum(assigi,assigj);
end
end
end
assigtig=assigtig';


%% Energy Calculation
Sx1272_transmission_configuration=[
7   -116  3.750*10^3    18*10^-3   10.5*10^-3   0 0 7 0 -7.5;
7   -119  18.75*10^3    18*10^-3   10.5*10^-3   0 0 8 0 -10;
7   -122  9.380*10^3    18*10^-3   10.5*10^-3   0 0 9 0 -12.5;
7   -131  1.172*10^3    18*10^-3   10.5*10^-3   0 0 10 0 -15;
7   -134  0.586*10^3    18*10^-3   10.5*10^-3   0 0 11 0 -17.5;
7   -137  0.293*10^3    18*10^-3   10.5*10^-3   0 0 12 0 -20;
13  -116  3.750*10^3    28*10^-3   10.5*10^-3   0 0 7 0 -7.5;
13  -119  18.75*10^3    28*10^-3   10.5*10^-3   0 0 8 0 -10;
13  -122  9.380*10^3    28*10^-3   10.5*10^-3   0 0 9 0 -12.5;
13  -131  1.172*10^3    28*10^-3   10.5*10^-3   0 0 10 0 -15;
13  -134  0.586*10^3    28*10^-3   10.5*10^-3   0 0 11 0 -17.5;
13  -137  0.293*10^3    28*10^-3   10.5*10^-3   0 0 12 0 -20;
17  -116  3.750*10^3    90*10^-3   10.5*10^-3   0 0 7 0 -7.5;
17  -119  18.75*10^3    90*10^-3   10.5*10^-3   0 0 8 0 -10;
17  -122  9.380*10^3    90*10^-3   10.5*10^-3   0 0 9 0 -12.5;
17  -131  1.172*10^3    90*10^-3   10.5*10^-3   0 0 10 0 -15;
17  -134  0.586*10^3    90*10^-3   10.5*10^-3   0 0 11 0 -17.5;
17  -137  0.293*10^3    90*10^-3   10.5*10^-3   0 0 12 0 -20;
20  -116  3.750*10^3    125*10^-3  10.5*10^-3   0 0 7 0 -7.5;
20  -119  18.75*10^3    125*10^-3  10.5*10^-3   0 0 8 0 -10;
20  -122  9.380*10^3    125*10^-3  10.5*10^-3   0 0 9 0 -12.5;
20  -131  1.172*10^3    125*10^-3  10.5*10^-3   0 0 10 0 -15;
20  -134  0.586*10^3    125*10^-3  10.5*10^-3   0 0 11 0 -17.5;
20  -137  0.293*10^3    125*10^-3  10.5*10^-3   0 0 12 0 -20];
for i= 1:length(Sx1272_transmission_configuration)
Sx1272_transmission_configuration(i,9)=-174+10*log10(input_BW)+input_NF+Sx1272_transmission_configuration(i,10);
Sx1272_transmission_configuration(i,6)= Sx1272_transmission_configuration(i,1)-Sx1272_transmission_configuration(i,9); % calculating total power budget
Sx1272_transmission_configuration(i,7)=10^((Sx1272_transmission_configuration(i,6)-23.3-21*log10(operating_frequency/900))/37.6); % calculating Maximum transmission distance
%Sx1272_transmission_configuration(i,8)=(Size_of_a_packet/Sx1272_transmission_configuration(i,3)*10^3)*(Sx1272_transmission_configuration(i,4)*10^-3)*supply_voltage; % calculating packet transmit energy
end
Sx1272_transmission_configuration;

% rearrange the matrix based on Maximum transmission distance column in ascending order

Sx1272_transmission_configuration_rearranged=sortrows(Sx1272_transmission_configuration,7); % the matrix is sorted based on the last column of Sx1272_transmission_configuration

% Separate the distance column from Sx1272_transmission_configuration_rearranged;
distance_for_different_transmission_configuration=[];
for i=1:length(Sx1272_transmission_configuration_rearranged)
distance_for_different_transmission_configuration(i)=Sx1272_transmission_configuration_rearranged(i,7);
SX1272sens(i)=Sx1272_transmission_configuration_rearranged(i,2);  
SX1272bitr(i)=Sx1272_transmission_configuration_rearranged(i,3);
SX1272SF(i)=Sx1272_transmission_configuration_rearranged(i,8);
%  SX1272SF(i)=ceil(log(input_BW/SX1272bitr(i))/log(2));
end
distance_for_different_transmission_configuration;

SX1272=Sx1272_transmission_configuration_rearranged;
SX1272D=distance_for_different_transmission_configuration;
currentm=zeros(node,length(SX1272));
currents=zeros(node,1);

%% TR Calculation for nodes
SX1272DSORT=sort(SX1272D);
for i=1:node
for j=1:length(SX1272)
if (rr(i)*1000) <= SX1272DSORT(j)              
TR(i)=SX1272DSORT(j); 
break
elseif (rr(i)*1000)>max(SX1272DSORT)
TR(i)=rr(i)*1000;
end
end

for k=1:length(SX1272)
if TR(i)== SX1272D(k)
currents(i,1)=k;
break
elseif TR(i)==(rr(i)*1000)
currents(i,1)=length(SX1272);
end
end

txpower(i)= SX1272(currents(i),1);
txcurrent(i)=SX1272(currents(i),4);
sensitivity(i)=SX1272(currents(i),9);
sfset(i)=SX1272(currents(i),8);
end
rxcurrent=0.0105; %Ampere

%% SX1301
Sx1301_transmission_configuration=[
7   -116  3.750*10^3    18*10^-3   10.5*10^-3   0 0 7 0 -7.5;
7   -119  18.75*10^3    18*10^-3   10.5*10^-3   0 0 8 0 -10;
7   -122  9.380*10^3    18*10^-3   10.5*10^-3   0 0 9 0 -12.5;
7   -131  1.172*10^3    18*10^-3   10.5*10^-3   0 0 10 0 -15;
7   -134  0.586*10^3    18*10^-3   10.5*10^-3   0 0 11 0 -17.5;
7   -137  0.293*10^3    18*10^-3   10.5*10^-3   0 0 12 0 -20;
13  -116  3.750*10^3    28*10^-3   10.5*10^-3   0 0 7 0 -7.5;
13  -119  18.75*10^3    28*10^-3   10.5*10^-3   0 0 8 0 -10;
13  -122  9.380*10^3    28*10^-3   10.5*10^-3   0 0 9 0 -12.5;
13  -131  1.172*10^3    28*10^-3   10.5*10^-3   0 0 10 0 -15;
13  -134  0.586*10^3    28*10^-3   10.5*10^-3   0 0 11 0 -17.5;
13  -137  0.293*10^3    28*10^-3   10.5*10^-3   0 0 12 0 -20;
17  -116  3.750*10^3    90*10^-3   10.5*10^-3   0 0 7 0 -7.5;
17  -119  18.75*10^3    90*10^-3   10.5*10^-3   0 0 8 0 -10;
17  -122  9.380*10^3    90*10^-3   10.5*10^-3   0 0 9 0 -12.5;
17  -131  1.172*10^3    90*10^-3   10.5*10^-3   0 0 10 0 -15;
17  -134  0.586*10^3    90*10^-3   10.5*10^-3   0 0 11 0 -17.5;
17  -137  0.293*10^3    90*10^-3   10.5*10^-3   0 0 12 0 -20;
20  -116  3.750*10^3    125*10^-3  10.5*10^-3   0 0 7 0 -7.5;
20  -119  18.75*10^3    125*10^-3  10.5*10^-3   0 0 8 0 -10;
20  -122  9.380*10^3    125*10^-3  10.5*10^-3   0 0 9 0 -12.5;
20  -131  1.172*10^3    125*10^-3  10.5*10^-3   0 0 10 0 -15;
20  -134  0.586*10^3    125*10^-3  10.5*10^-3   0 0 11 0 -17.5;
20  -137  0.293*10^3    125*10^-3  10.5*10^-3   0 0 12 0 -20];
for i= 1:length(Sx1301_transmission_configuration)
Sx1301_transmission_configuration(i,9)=-174+10*log10(input_BW)+input_NF+Sx1301_transmission_configuration(i,10);
Sx1301_transmission_configuration(i,6)= Sx1301_transmission_configuration(i,1)-Sx1301_transmission_configuration(i,9); % calculating total power budget
Sx1301_transmission_configuration(i,7)=10^((Sx1301_transmission_configuration(i,6)-23.3-21*log10(operating_frequency/900))/37.6); % calculating Maximum transmission distance
%Sx1272_transmission_configuration(i,8)=(Size_of_a_packet/Sx1272_transmission_configuration(i,3)*10^3)*(Sx1272_transmission_configuration(i,4)*10^-3)*supply_voltage; % calculating packet transmit energy
end
Sx1301_transmission_configuration;

% rearrange the matrix based on Maximum transmission distance column in ascending order

Sx1301_transmission_configuration_rearranged=sortrows(Sx1301_transmission_configuration,7); % the matrix is sorted based on the last column of Sx1272_transmission_configuration


%% TR Calculation for IG
currentig=zeros(sum(ig),1);
for i=1:sum(ig)
for j=1:length(SX1272)
if (rrig(i)*1000) <= SX1272DSORT(j)
TRIG(i)=SX1272DSORT(j);
break
elseif (rrig(i)*1000) > max(SX1272DSORT)
TRIG(i)=rrig(i)*1000;
end
end
for k=1:length(SX1272)
if TRIG(i)== SX1272D(k)
currentig(i,1)=k;
break
elseif TRIG(i)==(rrig(i)*1000)
currentig(i,1)=length(SX1272);
end
end
txpowerig(i)= SX1272(currentig(i),1);
txcurrentig(i)=SX1272(currentig(i),4);
sensitivityig(i)=SX1272(currentig(i),9);
sfsig(i)=SX1272(currentig(i),8);
end


%% TT Node

TT=[];
for i=1:node

Tsym=(2.^sfset(i))/input_BW;
Tpreamble=(input_preamble_length+4.25)*Tsym;
PayloadSymbNb_UL=8+ceil((8*input_B_UL-4*sfset(i)+28+16-20*input_H)/(4*sfset(i)))*(input_CR+4);
Tpayload_UL=PayloadSymbNb_UL*Tsym;
TOA(i)=Tpreamble+Tpayload_UL;
TT=[TT TOA(i)];

end

%max TT
Tsym=(2.^12)/input_BW;
Tpreamble=(input_preamble_length+4.25)*Tsym;
PayloadSymbNb_UL=8+ceil((8*input_B_UL-4*sfset(i)+28+16-20*input_H)/(4*sfset(i)))*(input_CR+4);
Tpayload_UL=PayloadSymbNb_UL*Tsym;
TT12=Tpreamble+Tpayload_UL;

%%
TTIG=[];
for i=1:sum(ig)

Tsym=(2.^sfsig(i))/input_BW;
Tpreamble=(input_preamble_length+4.25)*Tsym;
PayloadSymbNb_UL=8+ceil((8*input_B_UL-4*sfsig(i)+28+16-20*input_H)/(4*sfsig(i)))*(input_CR+4);
Tpayload_UL=PayloadSymbNb_UL*Tsym;
TOAI(i)=Tpreamble+Tpayload_UL;
TTIG=[TTIG TOAI(i)];

end

%%
x=ringnodes;
y=[];
zz=[];
CH=0.8+(1.1*log10(868)-0.7)*1-1.56*log10(868);
%Ldb=69.55+26.16*log10(868)-13.82*log10(24)-CH+(44.9-6.55*log10(24))*log10(dist/1000)%etai L
% SNR=[-20, -17.5, -15, -12.5, -10, -7.5]
SNR=[-7.5 -10 -12.5 -15 -17.5 -20];
SS=[];
SSIG=[];
PP=[];
PPIG=[];
RR=[];
RR2=[];
EE=[];
EEIG=[];
sfactor=[7 8 9 10 11 12];

%%
%node to ig TR R check
for i=1:n
for sfj=1:6
if sfset(i)==sfactor(sfj)

%S=sensitivity(i);
Prx=txpower(i)-(23.3+37.6*log10(rr(i)*1000)+21*log10(operating_frequency/900));
Erx=txcurrent(i)*operating_voltage*TT(i);
S=-174+10*log10(input_BW)+input_NF+SNR(sfj); %Rx sensitivity, dBm
%Prx=txpower(i)-(69.55+26.16*log10(868)-13.82*log10(24)-CH+(44.9-6.55*log10(24))*log10(TR(i)));

end
end

if (Prx==S)
R(i)=0;

elseif Prx>S
R(i)=0;
else
R(i)=1;
end
SS=[SS S];
PP=[PP Prx];
RR=[RR R(i)];
EE=[EE Erx];

end

%% ig to mg TR R check
RRIG=[];
for i=1:sum(ig)
for sfj=1:6
if sfsig(i)==sfactor(sfj)
%            Si=sensitivityig(i);
Prxi=txpowerig(i)-(23.3+37.6*log10(rrig(i)*1000)+21*log10(operating_frequency/900));
Erxi=(10^(((Prxi)-30)/10))*TTIG(i);
Si=-174+10*log10(input_BW)+input_NF+SNR(sfj); %Rx sensitivity, dBm

%Prx=txpower(i)-(69.55+26.16*log10(868)-13.82*log10(24)-CH+(44.9-6.55*log10(24))*log10(TR(i)));

end
end

if (Prxi==Si)%%%if (Prx==S)

IGR(i)=0;

elseif Prxi > Si
IGR(i)=0;
else
IGR(i)=1;
end

RRIG=[RRIG IGR(i)];
SSIG=[SSIG Si];
PPIG=[PPIG Prxi];

EEIG=[EEIG Erxi];
end

%% node capture effect check at receiver end
T=[6 -16 -18 -19 -19 -20;-24 6 -20 -22 -22 -22;-27 -27 6 -23 -25 -25;-30 -30 -30 6 -26 -28;-33 -33 -33 -33 6 -29;-36 -36 -36 -36 -36 6];
%  T=[1    -8    -9    -9    -9    -9;-11     1   -11   -12   -13   -13;-15   -13     1   -13   -14   -15;-19   -18   -17     1   -17   -18;-22   -22   -21   -20     1   -20;-25   -25   -25   -24   -23     1];
DR= zeros(1,node);
DRIG=zeros(1,sum(ig));

%FOR NODE
for i=1:node
%UL and RX1
if(sfset(i)==7)
DR(i)=1;

elseif(sfset(i)==8)
DR(i)=2;

elseif(sfset(i)==9)
DR(i)=3;

elseif(sfset(i)==10)
DR(i)=4;

elseif(sfset(i)==11)
DR(i)=5;

elseif(sfset(i)==12)
DR(i)=6;
end
end

%%%%FOR IG DR
for i=1:sum(ig)
%UL and RX1
if(sfsig(i)==7)
DRIG(i)=1;

elseif(sfsig(i)==8)
DRIG(i)=2;

elseif(sfsig(i)==9)
DRIG(i)=3;

elseif(sfsig(i)==10)
DRIG(i)=4;

elseif(sfsig(i)==11)
DRIG(i)=5;

elseif(sfsig(i)==12)
DRIG(i)=6;
end
end

%% duty cycle input, packet transmission interval determination

%DC START

for i=1:node
%UL and RX1
if(sfset(i)==7)
period(i)=TT(i)*(100-dutycycle);

elseif(sfset(i)==8)
period(i)=TT(i)*(100-dutycycle);

elseif(sfset(i)==9)
period(i)=TT(i)*(100-dutycycle);

elseif(sfset(i)==10)
period(i)=TT(i)*(100-dutycycle);

elseif(sfset(i)==11)
period(i)=TT(i)*(100-dutycycle);

elseif(sfset(i)==12)
period(i)=TT(i)*(100-dutycycle);
end

end
period;
period_max=ceil(max(period));
maxperiod=0; %periodicity activation
sz=end_t;
tm=zeros(node,sz);
toam=zeros(node,sz);
tm1=[];
kp=[];
em=zeros(node,sz);
mm=zeros(node,sz);
dm=zeros(node,sz);


%% Packet Generation
delseed=20;

if maxperiod==0
for i=1:node
z=time(i);
for j=1:sz
if j==1 && z == end_t || j==1 && z+round(period(i))> end_t
tm(i,j)=z;
del=randi(delseed);
z=z+round(period(i))+del;
elseif z == end_t || z < end_t
tm(i,j)= z;
del=randi(delseed);
z=z+round(period(i))+del;
else
tm(i,j)= 0;
end
end
end

else
for i=1:node
z=time(i);
for j=1:sz
if j==1 && z == end_t || j==1 && z+(period_max)> end_t
tm(i,j)=z;
del=randi(delseed);
z=z+round(period_max)+del;
elseif z == end_t || z < end_t
tm(i,j)= z;
del=randi(delseed);
z=z+round(period_max)+del;
else
tm(i,j)= 0;
end
end
end
end


%% Hop Time Consideration

TTH=[];
hopnd=[];
for hi=1:length(path)
if (hi-p(hi))==0
hop(hi)=1;
else
hop(hi)=hop(hi-p(hi))+1;
end
for j=1:nd(hi)
hopnd=[hopnd hop(hi)];
end
end

for ti=1:node
TTH(ti)=TT(ti)*hopnd(ti);
end

%% NODE-IG matrix
nodeig=zeros(node,max(hopnd));
for i=1:node
for j=1:hopnd(i)
if j==1
wig=assig(i);
nodeig(i,j)=wig;
else
wig=assigtig(wig);
nodeig(i,j)=wig;
end
end
end
%%
for i=1:node
for j=1:sz
    
if tm(i,j)==0
toam(i,j)=0;
em(i,j)=0;
mm(i,j)=0;
dm(i,j)=0;
else
toam(i,j)=TT(i);
em(i,j)=tm(i,j)+toam(i,j);%a=tm,b=tm+toa
mm(i,j)=(em(i,j)+tm(i,j))/2;
dm(i,j)=(em(i,j)-tm(i,j))/2;

end
end
end




%% Interference Analysis Section

uni=(unique( tm(:,:) )).';
store=zeros(node,sz);
collm=zeros(node,sz);
potc1=[];
record=[];
sen=[];
rec=[];
recini=[];
rec_new=[];
TXEN=[];
TXEIG=[];
RXE=[];
RXEIG=[];
pinig1=0;
pinig2=0;
pinig3=0;

for ff=1:length(uni)
potc=[];
inc=[];
strc=[];
strc1=[];
reception=[];

if ff==1
colcal=[];
preact=[];
colcalupd=[];
end

% active and transmissted detector section

for i=1:node
for u=1:sz
if uni(ff)==tm(i,u) && uni(ff)~=0

for s=1:node
if s~=i

for k=1:sz
if abs(mm(i,u)-mm(s,k))< (dm(i,u)+dm(s,k));

inc=[inc s];
strc=[inc i];
potc=unique(strc);


end
end
end
end
potc=[potc i];
potc=unique(potc);

end
end
end


if ff>1
if (uni(ff)-uni(ff-1)) <= ((max(TT)))%+ceil(del)))
active=setdiff(potc,colcal);
transmitted=setdiff(potc,preact);

else
preact=[];
colcal=[];
active=potc;
transmitted=potc;
colcalig1=[];
colcalig2=[];
colcalig3=[];

end
else
active=potc;
transmitted=potc;
end

% active and trasmitted detected and now packet loss check among them
%%

if length(transmitted)==1
sent=length(transmitted);

preact=transmitted;

for hloop=1:hopnd(transmitted)
if hloop==1
dirs=transmitted;
dir=assig(transmitted);
if RR(dirs)==1 %node to ig/mg
received=0;
received_new=0;
break;
else
received=sent;
received_new=sent;
end

else
dirs=dir;
dir=assigtig(dir);
if RRIG(dirs)==1
received=0;
received_new=0;
break;
else
received=sent;
received_new=sent;
end
end
end

elseif isempty(transmitted)
sent=0;
received=sent;
received_new=sent;
preact=transmitted;
end

if length(active) >1

colsi=[];
colsj=[];
colsij=[];
colst=[];
colcal=[];
colcal1=[];
colcal2=[];
colcal3=[];
colcalij=[];
colcalupd=[];
colcalig1=[];
colcalig2=[];
colcalig3=[];

channellist=[867.1 867.3 867.5 867.7 867.9 868.1 868.3 868.5];%European band 863-870 %867.1 867.3 867.5 867.7 867.9 868.1 868.3 868.5

%ch for nodes

for i=1:length(active)
idx=randperm(length(channellist),1);
chset(active(i))=randi([867,872],1,1);


for k=1:max(hopnd)
if nodeig(active(i),k)~=0 && nodeig(active(i),k) ~=sum(ig)+1
chsig(nodeig(active(i),k))=randi([867,872],1,1);
end

end

end


for i=1:length(active)

for hloopi=1:hopnd(active(i))
if hloopi==1 
diris=active(i);%source
diri=nodeig(active(i),hloopi);%destination
for j=1:length(active)
if i~=j
if hloopi<=hopnd(active(j))

hloopj=hloopi;
dirjs=active(j);%source
dirj=nodeig(active(j),hloopj);%destination

if  nodeig(active(i),hloopi)==nodeig(active(j),hloopj) && sfset(active(i)) == sfset (active(j)) && chset(active(i)) == chset(active(j)) && ((PP(active(i))-PP(active(j)))< T(DR(active(i)),DR(active(j))))% EC(diris,dirjs)==1    % && TC(i,j)==1

colcal1=[colcal1 active(i) active(j)];
colcalij=[colcalij colcal1];
colcalupd=unique(colcalij);
colcal=colcalupd;
aim1=1;
colcalig1=unique(colcalupd);

elseif nodeig(active(i),hloopi)==nodeig(active(j),hloopj) && chset(active(i)) == chset(active(j)) && ((PP(active(i))-PP(active(j)))< T(DR(active(i)),DR(active(j))))
colcal1=[colcal1 active(i) active(j)];
colcalij=[colcalij colcal1];
colcalupd=unique(colcalij);
colcal=colcalupd;
aim2=2;
colcalig1=unique(colcalupd);

end
end
end
end
%% energy calculation for 1st hop

if RR(active(i))==1  %node to next destination

colcal2=[colcal2 active(i)];
colcal3=unique(colcal2);
colcalij=[colcalij colcal3];
colcalupd=unique(colcalij);
colcal=colcalupd;
aimrr=10;
colcalig1=unique(colcalupd);

end

%Energy

for ti=1:length(transmitted)
if length(transmitted)>1
if transmitted(ti)==active(i)
recig1=setdiff(active(i),colcalig1);
if length(recig1)>0    
if hopnd(recig1)>1

ru=nodeig(recig1,hloopi);
%packet reception by ig
if ru<sum(ig)+1
recig1;
pinig1=pinig1+length(setdiff(active(i),colcalig1));
Receive_energy(ru)=rxcurrent*operating_voltage*TTIG(ru);
RXEIG=[RXEIG Receive_energy(ru)];

%packet transmission by ig
Transmit_energy(ru)=txcurrentig(ru)*operating_voltage*TTIG(ru);
TXEIG=[TXEIG Transmit_energy(ru)];

end
end
end
end
end
end

else %hloop more than 1

diris=nodeig(active(i),hloopi-1);
diri=nodeig(active(i),hloopi);
for j=1:length(active)
if i~=j  
if hloopi<=hopnd(active(j))
hloopj=hloopi;

dirjs=nodeig(active(j),hloopj-1);
dirj=nodeig(active(j),hloopj);

if diri==dirj && sfsig(diris) == sfsig (dirjs) && chsig(diris) == chsig(dirjs) && ((PPIG(diris)-PPIG(dirjs))< T(DRIG(diris),DRIG(dirjs)))% &&  EC(diri,dirj)==1    % && TC(i,j)==1

colcal1=[colcal1 active(i) active(j)];
colcalij=[colcalij colcal1];
colcalupd=unique(colcalij);
colcal=colcalupd;
aim7=7;
colcalig2=unique(colcalupd);
elseif diri==dirj && chsig(diris) == chsig(dirjs) && ((PPIG(diris)-PPIG(dirjs))< T(DRIG(diris),DRIG(dirjs)))% &&  EC(diri,dirj)==1    % && TC(i,j)==1

colcal1=[colcal1 active(i) active(j)];
colcalij=[colcalij colcal1];
colcalupd=unique(colcalij);
colcal=colcalupd;
aim8=8;
colcalig2=colcalupd;
end


end
end
end

%% energy more  than 1 hop
% if diris <sum(ig)+1
if RRIG(diris)==1  %ig to next destination
colcal2=[colcal2 active(i)];
colcal3=unique(colcal2);
colcalij=[colcalij colcal3];
colcalupd=unique(colcalij);
colcal=colcalupd;
aimrrig=9                            
colcalig2=colcalupd;
end

%energy               
for ti=1:length(transmitted)
if length(transmitted)>1
if transmitted(ti)==active(i)
recig2=setdiff(active(i),colcalig2);
if length(recig2)>0
if hopnd(recig2)>1

%packet reception by ig

ru=nodeig(recig2,hloopi);

if ru<sum(ig)+1
abul2=[];

pinig2=pinig2+length(recig2);
Receive_energy(ru)=rxcurrent*operating_voltage*TTIG(ru);
RXEIG=[RXEIG Receive_energy(ru)];

%packet transmission by ig
Transmit_energy(ru)=txcurrentig(ru)*operating_voltage*TTIG(ru);
TXEIG=[TXEIG Transmit_energy(ru)];

end

end
end
end
end
end

end                    
end
end

sent=length(transmitted);
received_1=setdiff(transmitted,colcal);

if length(received_1)>8
received=8;
else
received=length(received_1);
end

end

%Transmission energy by nodes

for cu=1:length(transmitted)
Transmit_energy(cu)=txcurrent(transmitted(cu))*operating_voltage*TT(transmitted(cu));
TXEN=[TXEN Transmit_energy(cu)];
relaypotig=relaypotig+hopnd(transmitted(cu))-1;

end

if length(transmitted)==1

if hopnd(transmitted)>1
pinig3=pinig3+hopnd(transmitted)-1;
for loopi=1:hopnd(transmitted)
if loopi==1
%packet reception by ig
ru=nodeig(transmitted,loopi);
%packet reception by ig
if ru<sum(ig)+1
Receive_energy(ru)=rxcurrent*operating_voltage*TTIG(ru);
RXEIG=[RXEIG Receive_energy(ru)];

%packet transmission by ig

Transmit_energy(ru)=txcurrentig(ru)*operating_voltage*TTIG(ru);
TXEIG=[TXEIG Transmit_energy(ru)];

end    

else 

ru=nodeig(transmitted,loopi);
%packet reception by ig
if ru<sum(ig)+1
Receive_energy(ru)=rxcurrent*operating_voltage*TTIG(ru);
RXEIG=[RXEIG Receive_energy(ru)];

%packet transmission by ig
Transmit_energy(ru)=txcurrentig(ru)*operating_voltage*TTIG(ru);
TXEIG=[TXEIG Transmit_energy(ru)];


end    

end
end
end
end

%% parameters to display
potc;
colcal;
sent;
received;
sen=[sen sent];
rec=[rec received];
preact=active;
ff;

end
sss=sum(sen);
sssstore=[sssstore sss];
rrr=sum(rec);
rrrstore=[rrrstore rrr];
relayig=[relayig pinig1+pinig2+pinig3];
Ps = [Ps rrr/sss];
total_energy=[total_energy sum(TXEN)+sum(TXEIG)+sum(RXEIG)];
igcount=[igcount sum(ig)];
tntx=[tntx sum(TXEN) ];
tigtx=[tigtx sum(TXEIG)];
trtx=[trtx sum(RXEIG)];
relaybyig=[relaybyig relaypotig];
end
send = [send mean(sssstore)];
send1=[send1 nnz(tm)];
recsen=[recsen mean(rrrstore)];
energycon=[energycon mean(total_energy)];
gwstore=[gwstore mean(igcount)];
P_DR = mean(Ps);
PDR = [PDR P_DR];
energynode=[energynode mean(tntx)];
energyar=[energyar mean(tntx) mean(tigtx) mean(trtx)];
forwardn=[forwardn mean(relayig)];
potentialrelay=[potentialrelay mean(relaybyig)];
end
inddatasave=[PDR energycon gwstore energyar send forwardn recsen];
ndinfo=[ndinfo nd];
totale=repelem(36,1,6); %total energy 
% nodenumber = repelem(node,1,6)
% total_energy_of_a_node = repelem(Total_e_battery,1,6) 
end
epn=[epn (energynode./send)./totale];
% e_consumption_per_node = [e_consumption_per_node (energynode./nodenumber)]; %avergae energy consumption per node within the simulation time (600 Seconds)
e_consumption_per_node = (energynode/node);
% percentage_e_consumption_of_node = [percentage_e_consumption_of_node (e_consumption_per_node./total_energy_of_a_node)*100]; %(energy_consumption_per_node is divided by the total energy stored by its battery), then it is multiplied by 100 for pecentage consumption
percentage_e_consumption_of_node = (e_consumption_per_node/Total_e_battery)*100;
send1;
potentialrelay;
percenfbyig=(forwardn./potentialrelay).*100;
send;
recsen;
energycon;
PDR;
gwstore;
energyar;

%% plot

figure(1)
scatter(x_r,y_r)
legend
hold on
scatter(0,0,'filled')
legend
hold on

scatter(xxig,yyig)
hold on
for i=1:number_of_rings
t=0:0.001:1;
sine=i*radius_of_ring*sin(2*pi*2*t);
cosine=i*radius_of_ring*cos(2*pi*2*t);
plot(sine,cosine);
hold on
end
legend('EN','MG','IG','RING','Location','northeast');
axis equal;
axis on;


%% Network Performance
fprintf('Routing Strategy is:')
fprintf('%2d', path)
fprintf('\n')   
fprintf('Node number is: %d', node)
fprintf('\n')  
fprintf('Required intermediate gateway number is: %1d',round(gwstore))
fprintf('\n')  
fprintf('Network Area Radius: %d km',areadef)
fprintf('\n')   
fprintf('Packet Delivery Ratio is: %f\n', PDR)
fprintf('The network was active for: %d seconds', end_t)
fprintf('\n')
fprintf('Average Energy Consumption of a node: %d percent in %d seconds duration', percentage_e_consumption_of_node, end_t)