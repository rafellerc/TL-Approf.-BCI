clear all;

% addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));

% addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));

X = load('herve001_labeled.txt');

delta_f = 1;
G = 0.1;

[prediction] = commande(X(:,1),0.002, delta_f, G);

erreur = erreurprediction(prediction, X(:,2))

axe = 1/256:1/256:size(prediction)/256;
plot(axe, prediction);
hold on;
plot(axe,X(:,2));
hold on;