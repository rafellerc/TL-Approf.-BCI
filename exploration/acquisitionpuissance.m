close all;
% addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));
% 
% % addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% % addpath(genpath('/Users/Rafael/sir/'));

addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));


X = load('herve003_labeled.txt');
% X = X(:,1);
fe = 256;
fc_1 = 7.5;
fc_2 = 11;
fc_3 = 13.5;
delta_f = 0.33; %Opt = 0.33
G = 0.56;  %Opt = 0.56
len_X = size(X);
T = (1/fe)*(0:len_X);
alpha = 0.5;


%Gets the indices of each command
idx_0 = X(:,2)==0;
idx_1 = X(:,2)==1;
idx_2 = X(:,2)==2;
idx_3 = X(:,2)==3;

[Y1] = filtre (X,G,delta_f,fe,fc_1);
[Y2] = filtre (X,G,delta_f,fe,fc_2);
[Y3] = filtre (X,G,delta_f,fe,fc_3);

Z1 = zeros(size(Y1,1),1);
Z1(1) = Y1(1,1)^2;
Z2 = zeros(size(Y2,1),1);
Z2(1) = Y2(1,1)^2;
Z3 = zeros(size(Y3,1),1);
Z3(1) = Y3(1,1)^2;

for i = 2:size(Y1,1)+1
    Z1(i) = (1-alpha)*Y1(i)^2 + alpha * Z1(i-1)^2;
    Z2(i) = (1-alpha)*Y2(i)^2 + alpha * Z2(i-1)^2;
    Z3(i) = (1-alpha)*Y3(i)^2 + alpha * Z3(i-1)^2;
end

%filters the singal in with fcut ~ 7 Hz. To allow to get only the value
%corresponding to the amplitude
windowSize = 36; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

%And passes also through the abs function so as to not have zero mean in a
%period
Z1 = filter(b,a,Z1);
Z2 = filter(b,a,abs(Z2));
Z3 = filter(b,a,abs(Z3));

k =10;
[d1_puissance] = derivee(fe,k,Z1);
[d2_puissance] = derivee(fe,k,Z2);
[d3_puissance] = derivee(fe,k,Z3);


ax1 = subplot(3,1,1);
% figure
plot(T(idx_0),Z1(idx_0,1)','r',T(idx_1),Z1(idx_1,1)','b',T(idx_2),Z1(idx_2,1)','y',T(idx_3),Z1(idx_3,1),'k')';
hold on;
hold on;
ax2 = subplot(3,1,2);
% figure
plot(T(idx_0),Z2(idx_0,1),'r',T(idx_1),Z2(idx_1,1),'b',T(idx_2),Z2(idx_2,1),'y',T(idx_3),Z2(idx_3,1),'k');
ax3 = subplot(3,1,3);
% figure
plot(T(idx_0),Z3(idx_0,1),'r',T(idx_1),Z3(idx_1,1),'b',T(idx_2),Z3(idx_2,1),'y',T(idx_3),Z3(idx_3,1),'k');

% %Affichage de la dérivée de la puissance (Z1, Z2, Z3)
% ax1 = subplot(3,1,1);
% % figure
% plot(T(idx_0),d1_puissance(idx_0,1)','r',T(idx_1),d1_puissance(idx_1,1)','b',T(idx_2),d1_puissance(idx_2,1)','y',T(idx_3),d1_puissance(idx_3,1),'k')';
% hold on;
% hold on;
% ax2 = subplot(3,1,2);
% % figure
% plot(T(idx_0),d2_puissance(idx_0,1),'r',T(idx_1),d2_puissance(idx_1,1),'b',T(idx_2),d2_puissance(idx_2,1),'y',T(idx_3),d2_puissance(idx_3,1),'k');
% ax3 = subplot(3,1,3);
% % figure
% plot(T(idx_0),d3_puissance(idx_0,1),'r',T(idx_1),d3_puissance(idx_1,1),'b',T(idx_2),d3_puissance(idx_2,1),'y',T(idx_3),d3_puissance(idx_3,1),'k');

%Lines of reference.

% refline(ax2,[0 1e-3]);
% refline(ax3,[0 1e-3]);

%% 
% figure (1);
% plot(Y1,'r')
% figure (2);
% plot(Y2,'b')
% figure (3);
% plot (Y3,'g')