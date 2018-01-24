% addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));
clear all
close all
addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));


B = load('herve001.txt');
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
alpha = 0.99;

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
Z1 = filter(b,a,abs(Z1));
Z2 = filter(b,a,abs(Z2));
Z3 = filter(b,a,abs(Z3));

%On détermine la puissance du bruit, les 5 premières secondes,
%caractérisant l'absence de signal, le seuil en deça duquel on considère
%qu'aucun ordre n'est donné

bruit_1 = sum(Z1(1:5*256))/(5*256);
bruit_2 = sum(Z2(1:5*256))/(5*256);
bruit_3 = sum(Z3(1:5*256))/(5*256);

max_Z1 = max(abs(Z1));
max_Z2 = max(abs(Z2));
max_Z3 = max(abs(Z3));
seuil_1 = zeros(100,1);
seuil_2 = zeros(100,1);
seuil_3 = zeros(100,1);
seuil = zeros(100,3);

%On incrémente les seuils de 1/100*(l'amplitude max. du signal) pour
%trouver les seuils optimaux
for i = 1:100
    seuil_1(i)=bruit_1+((max_Z1/100)*(i-1));
    seuil_2(i)=bruit_2+((max_Z2/100)*(i-1));
    seuil_3(i)=bruit_3+((max_Z3/100)*(i-1));
    seuil(i,1)=seuil_1(i);
    seuil(i,2)=seuil_2(i);
    seuil(i,3)=seuil_3(i);

end

prediction = zeros(length(Z1)-1,100);


%On calcule la prédiction correspondante sur chaque fenêtre de temps, pour
%chaque signal et pour chaque incrémentation des seuils
for j=1:100
    
    for i = 36:length(Z1)-1
    
    est_amp_1 = max(abs(Z1(i-35:i)));
    est_amp_2 = max(abs(Z2(i-35:i)));
    est_amp_3 = max(abs(Z3(i-35:i)));
    
    if(est_amp_1<seuil(j,1) && est_amp_2<seuil(j,2) && est_amp_3<seuil(j,3))
        prediction(i,j) = 0;
    elseif((est_amp_1>est_amp_2 && est_amp_1>est_amp_3) ||  (est_amp_1>seuil(j,1))) %&& est_amp_2<seuil(j,2) && est_amp_3<seuil(j,3)))
        prediction(i,j) = 3;
    elseif((est_amp_2>est_amp_1 && est_amp_2>est_amp_3) || (est_amp_2>seuil(j,2) )) %&& est_amp_1<seuil(j,1) && est_amp_3<seuil(j,3)))
        prediction(i,j) = 1;
    elseif ((est_amp_3>est_amp_1 && est_amp_3>est_amp_2)  || ( est_amp_3>seuil(j,3))) %&& est_amp_1<seuil(j,1) && est_amp_2<seuil(j,2)))
        prediction(i,j) = 2;
    end
    end

%On calcule le pourcentage d'ordres erronés donnés pour chaque seuil 
%par la fonction erreurprediction 
erreur(j) = erreurprediction(prediction(:,j),X(:,2));

end



%On choisit pour chaque signal le seuil donnant l'erreur de prédiction
%minimale
[val_min,ind_min] = min(erreur);

seuil1 = seuil_1(ind_min);
seuil2 = seuil_2(ind_min);
seuil3 = seuil_3(ind_min);
