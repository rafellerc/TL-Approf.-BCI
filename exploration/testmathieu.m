clear all;

addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));
addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));


filename = 'total_droite';

fe  = 256;
data = load(strcat(filename, '.txt'));
G=1;
df =1;


for i = 1:length(data)
    for k = 1:3
        y(i,k) = ;
    end
end