function [S] = puissancelisse (X)

G = 0.35; %0.4
delta_f = 0.46; %0.4
alpha = 0.9;
fe = 256;
windowSize = 36; 
fc = [7.5 11 13.5];


[Y1] = filtre (X,G, delta_f, fe,fc(1));
[Y2] = filtre (X,G, delta_f, fe,fc(2));
[Y3] = filtre (X,G, delta_f, fe,fc(3));
   

figure
plot (Y1);
            
Z1 = zeros(size(Y1,1),1);
Z1(1) = Y1(1,1)^2;
Z2 = zeros(size(Y2,1),1);
Z2(1) = Y2(1,1)^2;
Z3 = zeros(size(Y3,1),1);
Z3(1) = Y3(1,1)^2;

for l = 2:size(Y1,1)
  Z1(l) = (1-alpha)*Y1(l)^2 + alpha * Z1(l-1)^2;
  Z2(l) = (1-alpha)*Y2(l)^2 + alpha * Z2(l-1)^2;
  Z3(l) = (1-alpha)*Y3(l)^2 + alpha * Z3(l-1)^2;
end


%filters the singal in with fcut ~ 7 Hz. To allow to get only the value
%corresponding to the amplitude


b = (1/windowSize)*ones(1,windowSize);
a = 1;

%And passes also through the abs function so as to not have zero mean in a
%period
            
Z1 = filter(b,a,abs(Z1));
Z2 = filter(b,a,abs(Z2));
Z3 = filter(b,a,abs(Z3));

S = [Z1 Z2 Z3];