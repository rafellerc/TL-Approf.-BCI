% addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));

% addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));

X = load('herve002_labeled.txt');

labels = X(:,2);
X = X(:,1);
fe = 256;
fc_1 = 7.5;
fc_2 = 11;
fc_3 = 13.5;


G = 0.01:0.01:5;
delta_f = 0.01:0.01:3;

SNRmat = zeros (length(G), length(delta_f));

SNRmax = 0;
Gopt = 0;
delta_fopt = 0;

for i = 1:length(G)
    for j = 1:length(delta_f)   
        [Y1] = filtre (X,G(i),delta_f(j),fe,fc_1);
        [Y2] = filtre (X,G(i),delta_f(j),fe,fc_2);
        [Y3] = filtre (X,G(i),delta_f(j),fe,fc_3);
        [resultat] = SNR(Y1, Y2, Y3, labels);
        SNRmat(i,j) = resultat;
        if resultat >SNRmax
            SNRmax = resultat;
            Gopt = G(i);
            delta_fopt = delta_f(j);
            
        end
    end
    i
end

mesh(delta_f, G, SNRmat);