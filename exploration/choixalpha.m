addpath(genpath('..\acquisition_biosemi\Enregistrements'));
addpath(genpath('..\obj'));
addpath(genpath('..\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));

addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));


X = load('herve002_labeled.txt');

labels = X(:,2);
X = X(:,1);
fe = 256;
fc_1 = 7.5;
fc_2 = 11;
fc_3 = 13.5;


<<<<<<< HEAD
G = 1:1:1;
delta_f = 1:1:1;
alpha = 0.1:0.1:1;
=======
%G = 0.01:0.05:1;
%delta_f = 0.01:0.05:1;
G = 0.56;
delta_f = 0.33;
alpha = 0.01:0.01:1;
>>>>>>> ee97a9ebb80d116aba7ef66ba01d7b81588418c3

SNRmat = zeros (length(alpha));
%SNRmat = zeros (length(G), length(delta_f), length(alpha));

SNRmax = 0;
%Gopt = 0;
%delta_fopt = 0;

alpha_opt = 0;
%for i = 1:length(G)
 %   for j = 1:length(delta_f)
        for k=1:length(alpha)
%             [Y1] = filtre (X,G(i),delta_f(j),fe,fc_1);
%             [Y2] = filtre (X,G(i),delta_f(j),fe,fc_2);
%             [Y3] = filtre (X,G(i),delta_f(j),fe,fc_3);
            [Y1] = filtre (X,G,delta_f,fe,fc_1);
            [Y2] = filtre (X,G,delta_f,fe,fc_2);
            [Y3] = filtre (X,G,delta_f,fe,fc_3);
            
            
            Z1 = zeros(size(Y1,1),1);
            Z1(1) = Y1(1,1)^2;
            Z2 = zeros(size(Y2,1),1);
            Z2(1) = Y2(1,1)^2;
            Z3 = zeros(size(Y3,1),1);
            Z3(1) = Y3(1,1)^2;

            
            
            for l = 2:size(Y1,1)
                Z1(l) = (1-alpha(k))*Y1(l)^2 + alpha(k) * Z1(l-1);
                Z2(l) = (1-alpha(k))*Y2(l)^2 + alpha(k) * Z2(l-1);
                Z3(l) = (1-alpha(k))*Y3(l)^2 + alpha(k) * Z3(l-1);
            end
            
                        %filters the singal in with fcut ~ 7 Hz. To allow to get only the value
            %corresponding to the amplitude
            windowSize = 36; 
            b = (1/windowSize)*ones(1,windowSize);
            a = 1;

            %And passes also through the abs function so as to not have zero mean in a
            %period
            Z1 = filter(b,a,Z1);
            Z2 = filter(b,a,Z2);
            Z3 = filter(b,a,Z3);
%             
            
            
            
            [resultat] = SNR(Z1, Z2, Z3, labels);
           % SNRmat(i,j,k) = resultat;
           SNRmat(k) = resultat;


            if resultat >SNRmax
                SNRmax = resultat;
               % Gopt = G(i);
                %delta_fopt = delta_f(j);
                alpha_opt = alpha(k);
            end
    k
end
%plot (alpha, SNR)
%mesh(delta_f, G, SNRmat(:,1:2));