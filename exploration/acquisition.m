close all;
addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));
addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));

addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
addpath(genpath('/Users/Rafael/sir/'));

% addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));


X = load('herve001_labeled.txt');
% X = X(:,1);
fe = 256;
fc_1 = 7.5;
fc_2 = 11;
fc_3 = 13.5;
delta_f = 0.33; %Opt = 0.33
G = 0.56;  %Opt = 0.56
len_X = size(X);
T = (1/fe)*(0:len_X);


%Gets the indices of each command
%Donne les indices de chaque ordre
idx_0 = X(:,2)==0;
idx_1 = X(:,2)==1;
idx_2 = X(:,2)==2;
idx_3 = X(:,2)==3;

[Y1] = filtre (X,G,delta_f,fe,fc_1);
[Y2] = filtre (X,G,delta_f,fe,fc_2);
[Y3] = filtre (X,G,delta_f,fe,fc_3);
%%
%filters the singal in with fcut ~ 7 Hz. To allow to get only the value
%corresponding to the amplitude
%Filtrage du signal à une fréquence de coupure ~7Hz pour n'observer que les
%valeurs correspondant à l'amplitude
windowSize = 36; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

%And passes also through the abs function so as to not have zero mean in a
%period
%Passage à la valeur absolue pour ne pas avoir une moyenne nulle sur un
%période
Y1 = filter(b,a,abs(Y1));
Y2 = filter(b,a,abs(Y2));
Y3 = filter(b,a,abs(Y3));



ax1 = subplot(3,1,1);
% figure
plot(T(idx_0),Y1(idx_0,1),'r',T(idx_1),Y1(idx_1,1),'b',T(idx_2),Y1(idx_2,1),'y',T(idx_3),Y1(idx_3,1),'k');
ax2 = subplot(3,1,2);
% figure
plot(T(idx_0),Y2(idx_0,1),'r',T(idx_1),Y2(idx_1,1),'b',T(idx_2),Y2(idx_2,1),'y',T(idx_3),Y2(idx_3,1),'k');
ax3 = subplot(3,1,3);
% figure
plot(T(idx_0),Y3(idx_0,1),'r',T(idx_1),Y3(idx_1,1),'b',T(idx_2),Y3(idx_2,1),'y',T(idx_3),Y3(idx_3,1),'k');

% % %Affichage de la dérivée de Y1, Y2, Y3 
% ax1 = subplot(3,1,1);
% % figure
% plot(T(idx_0),d1(idx_0,1),'r',T(idx_1),d1(idx_1,1),'b',T(idx_2),d1(idx_2,1),'y',T(idx_3),d1(idx_3,1),'k');
% ax2 = subplot(3,1,2);
% % figure
% plot(T(idx_0),d2(idx_0,1),'r',T(idx_1),d2(idx_1,1),'b',T(idx_2),d2(idx_2,1),'y',T(idx_3),d2(idx_3,1),'k');
% ax3 = subplot(3,1,3);
% % figure
% plot(T(idx_0),d3(idx_0,1),'r',T(idx_1),d3(idx_1,1),'b',T(idx_2),d3(idx_2,1),'y',T(idx_3),d3(idx_3,1),'k');

%Lines of reference.
%Courbes de référence
refline(ax1,[0 1e-3]);
refline(ax2,[0 1e-3]);
refline(ax3,[0 1e-3]);

%% 
% figure (1);
% plot(Y1,'r')
% figure (2);
% plot(Y2,'b')
% figure (3);
% plot (Y3,'g')
