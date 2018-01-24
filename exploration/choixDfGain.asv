% addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
% addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));

% addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));

%Chargement des données
X = load('herve001_labeled.txt');

%Variables
labels = X(:,2);
X = X(:,1);
fe = 256;
fc_1 = 7.5;
fc_2 = 11;
fc_3 = 13.5;

%Choix du range et de la précision pour le choix des G et demta_f optimaux

G = 0.1:0.1:5;
delta_f = 0.1:0.1:3;

% Matrice qui va recevoir tous les Rapport signal sur bruit pour chaque G
% et delta_f
SNRmat = zeros (length(G), length(delta_f));

%Variables correspondant à l'optimal
SNRmax = 0;
Gopt = 0;
delta_fopt = 0;

%Grid search sur les valeures de G et delta_f
for i = 1:length(G)
    for j = 1:length(delta_f)
        
        % 
        [Y1] = filtre (X,G(i),delta_f(j),fe,fc_1);
        [Y2] = filtre (X,G(i),delta_f(j),fe,fc_2);
        [Y3] = filtre (X,G(i),delta_f(j),fe,fc_3);
        
        windowSize = 36; 
        b = (1/windowSize)*ones(1,windowSize);
        a = 1;

        %And passes also through the abs function so as to not have zero mean in a
        %period
        Y1 = filter(b,a,abs(Y1));
        Y2 = filter(b,a,abs(Y2));
        Y3 = filter(b,a,abs(Y3));
        
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