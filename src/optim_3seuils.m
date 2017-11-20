% addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));

addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));


X = load('herve002.txt');
H = load('herve002_labeled.txt');

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

max_Z1 = max(abs(Z1));
max_Z2 = max(abs(Z2));
max_Z3 = max(abs(Z3));
seuil_1 = zeros(10,1);
seuil_2 = zeros(10,1);
seuil_3 = zeros(10,1);

for i = 1:10
    seuil_1(i)=(max_Z1/10)*i;
    seuil_2(i)=(max_Z2/10)*i;
    seuil_3(i)=(max_Z3/10)*i;
   prediction_1(:,i) = commande(X,seuil_1(i),delta_f, G);
   prediction_2(:,i) = commande(X,seuil_2(i),delta_f, G);
   prediction_3(:,i) = commande(X,seuil_3(i),delta_f, G);
   erreur_1(i)= erreurprediction(prediction_1(:,i), H(:,2));
   erreur_2(i)= erreurprediction(prediction_2(:,i), H(:,2));
   erreur_3(i)= erreurprediction(prediction_3(:,i), H(:,2));

end

[Y_1,I_1] = min(erreur_1);
[Y_2,I_2] = min(erreur_2);
[Y_3,I_3] = min(erreur_3);

seuil1 = (max_Z1/10)*I_1;
seuil2 = (max_Z2/10)*I_2;
seuil3 = (max_Z3/10)*I_3;
