clear all;

addpath(genpath('..\acquisition_biosemi\Enregistrements'));
addpath(genpath('..\obj'));
addpath(genpath('..\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));

% addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));
figure;
X = load('herve001_labeled.txt');
X(:,1) = X(:,1).*30;
Y = 1/256:1/256:length(X(:,1))/256
plot(Y,X(:,2));
xlabel('Temps (en s)');
ylabel('Amplitude du signal');
legend('signal','label');
set(gca,'FontSize',16);