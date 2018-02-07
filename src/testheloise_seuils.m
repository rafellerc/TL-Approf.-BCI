clear all
close all
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));
addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));

%Le signal B est la moyenne de la sortie des 2 électrodes
%Le signal X contient la sortie des électrodes et les labels des ordres
%donnés, obtenu par separerOrdres
B = load('herve003.txt');
X = load('herve003_labeled.txt');

%delta_f, G et alpha sont ceux trouvés par choixaplha
fe = 256;
fc_1 = 7.5;
fc_2 = 11;
fc_3 = 13.5;
delta_f = 0.33; %Opt = 0.33
G = 0.56;  %Opt = 0.56
len_X = size(X);
T = (1/fe)*(0:len_X);
alpha = 0.9600;
t = 2;

% Les seuils sont ceux trouvés par optmin_3seuils 
%pour chacun des 3 enregistrements :

% seuil1 = 9.05e-07;%herve001
% seuil2 = 9.6e-07;
% seuil3 = 8.61e-07;
% 
% seuil1 = 6.2155e-07;%herve001 par optim3seuilsbis alpha = 0.99
% seuil2 = 8.8976e-07;
% seuil3 = 8.5375e-07;

% seuil1= 1.1533e-06; %herve002
% seuil2 = 6.767e-07;
% seuil3 = 4.849e-07;
% 
% seuil1= 3.4917e-08; %herve002 optim_3seuilsbis alpha = 0,99
% seuil2 = 2.088e-08;
% seuil3 = 1.4431e-08;
% % 
% seuil1= 2.3358e-06; %herve002 optim_3seuilsbis alpha = 0,99 erreur = 12,71
% seuil2 = 1.4505e-06;
% seuil3 = 1.2756e-06;


seuil1= 2.8862e-06; %herve002 optim_3seuilsbis num2 alpha = 0,96  erreur = 11,1
seuil2 = 1.7285e-06;
seuil3 = 1.3574e-06;

% seuil1= 3.4898e-06; %herve002 optim_3seuilsbis num2 alpha = 0,105  erreur = 11,5
% seuil2 = 2.0086e-06;
% seuil3 = 1.4407e-06;
% 
% seuil1= 3.3325e-06; %herve002 optim_3seuilsbis num2 alpha = 0,83  erreur = 11,4
% seuil2 = 1.9546e-06;
% seuil3 = 1.3930e-06;

% seuil1= 3.4417e-06; %herve002 optim_3seuilsbis num2 alpha = 0,675  erreur = 11,4
% seuil2 = 1.9929e-06;
% seuil3 = 1.4111e-06;

% seuil1= 3.3562e-06; %herve002 optim_3seuilsbis num2 alpha = 0,81  erreur = 11,4
% seuil2 = 1.9634e-06;
% seuil3 = 1.3957e-06;

% seuil1= 3.4497e-06; %herve002 optim_3seuilsbis num2 alpha = 0,65 erreur = 11,4
% seuil2 = 1.9955e-06;
% seuil3 = 1.4139e-06;

% seuil1= 1.304e-06; %herve003
% seuil2 = 6.757e-07;
% seuil3 = 4.108e-07;

% % 
% seuil1= 2.7354e-06; %herve003 optim_3seuilsbis alpha = 0.99 erreur = 15,45
% seuil2 = 1.9553e-06;
% seuil3 = 1.0250e-06;


%On calcule la prediction des commandes données dans X en fonction des
%seuils, de delta_f, de G et de alpha
[prediction] = commande_3seuils(X, seuil1, seuil2, seuil3 ,delta_f, G,alpha);

%On calcule la prédiction corrigée : qui ne prend pas en compte un ordre
%durant moins de t
%[prediction_ts] = commande_ts(prediction,t);

%On calcule l'erreur entre la prédiction corrigée et les labels des ordres
[erreur] = erreurprediction(prediction,X(:,2));

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
    Z1(i) = (1-alpha)*Y1(i)^2 + alpha * Z1(i-1);
    Z2(i) = (1-alpha)*Y2(i)^2 + alpha * Z2(i-1);
    Z3(i) = (1-alpha)*Y3(i)^2 + alpha * Z3(i-1);
end


%filters the signal in with fcut ~ 7 Hz. To allow to get only the value
%corresponding to the amplitude
windowSize = 36; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

%And passes also through the abs function so as to not have zero mean in a
%period
Z1 = filter(b,a,Z1);
Z2 = filter(b,a,Z2);
Z3 = filter(b,a,Z3);


%[resultat] = SNR(Y1, Y2, Y3,X(:,2))
%plot (resultat);
ax1 = subplot(3,1,1);
figure
plot(Z1);
plot(T(idx_0),Z1(idx_0,1)','r',T(idx_1),Z1(idx_1,1)','b',T(idx_2),Z1(idx_2,1)','g',T(idx_3),Z1(idx_3,1),'k')';
hold on;

plot(Z2);
hold on;

plot(Z3);
ax2 = subplot(3,1,2);
figure
plot(T(idx_0),Z2(idx_0,1),'r',T(idx_1),Z2(idx_1,1),'b',T(idx_2),Z2(idx_2,1),'g',T(idx_3),Z2(idx_3,1),'k');
ax3 = subplot(3,1,3);
figure
plot(T(idx_0),Z3(idx_0,1),'r',T(idx_1),Z3(idx_1,1),'b',T(idx_2),Z3(idx_2,1),'g',T(idx_3),Z3(idx_3,1),'k');
hold on;
% %Lines of reference.
 refline(ax1,[0 seuil1]);
 refline(ax2,[0 seuil2]);
 refline(ax3,[0 seuil3]);