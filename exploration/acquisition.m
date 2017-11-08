close all;
addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI/obj'));
addpath(genpath('/Users/heloisehuyghuesdespointes/Documents'));
X = load('herve002_labeled.txt');
X = X(:,1);
fe = 256;
fc_1 = 7.5;
fc_2 = 11;
fc_3 = 13.5;
delta_f = 1;
G = 0.1;

[Y1] = filtre (X,G,delta_f,fe,fc_1);
[Y2] = filtre (X,G,delta_f,fe,fc_2);
[Y3] = filtre (X,G,delta_f,fe,fc_3);

figure (1);
plot(Y1,'r')
figure (2);
plot(Y2,'b')
figure (3);
plot (Y3,'g')
