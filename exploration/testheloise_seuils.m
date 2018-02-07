clear all
close all
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));
addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));

X = load('herve001.txt');
test = 64*256-256*4+1;
ER(:,1) = X(256*4:64*256, 1);
ER(:,2) = X(1:test, 2);
X=ER;
H = load('herve001_labeled.txt');
ER1(:,1) = H(256*4:64*256, 1);
ER1(:,2) = H(1:test, 2);
H = ER1;

%Seuils trouvés par optmin_3seuils :

seuil1 = 8.248973500628333e-07;%herve001
seuil2 = 1.101624763974626e-06;
seuil3 = 8.897782125760975e-07;

% seuil1= 9.475963607714598e-07; %herve002
% seuil2 = 5.408785533406508e-07;
% seuil3 = 4.013440462305411e-07;

% seuil1= 1.483220209930280e-06; %herve003
% seuil2 = 7.972323921168422e-07;
% seuil3 = 4.221290732907844e-07;

fe = 256;
delta_f = 0.33; %Opt = 0.33
G = 0.56;  %Opt = 0.56
len_X = size(X);
T = (1/fe)*(0:len_X);
alpha = 0.99;

[prediction] = commande_3seuils(X, seuil1, seuil2, seuil3 ,delta_f, G,alpha);
[erreur] = erreurprediction(prediction,H(:,2));