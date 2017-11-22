function [ bruit ] = niveaubruit(X)

Y = puissancelisse(X);
bruit_1 = sum(Y(1:5*256, 1))/(5*256);
bruit_2 = sum(Y(1:5*256, 2))/(5*256);
bruit_3 = sum(Y(1:5*256, 3))/(5*256);

bruit = [bruit_1 bruit_2 bruit_3];
end

