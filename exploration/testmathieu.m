clear all;

addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));
addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));

% addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));

X = load('herve002_labeled.txt');
X(:,1) = X(:,1).*10
Y = 1/256:1/256:length(X(:,1))/256
plot(Y,X);
xlabel('Temps (en s)');
ylabel('Amplitude du signal');
set(gca,'FontSize',16);