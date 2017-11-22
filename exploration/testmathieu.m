clear all;

addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));
addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\obj'));
addpath(genpath('C:\Users\daviet_mat\TL-Approf.-BCI\src'));

% addpath(genpath('/Users/Rafael/sir/TL-Approf.-BCI/obj'));
% addpath(genpath('/Users/Rafael/sir/'));

% addpath(genpath('/Users/heloisehuyghuesdespointes/Documents/TL-Approf.-BCI'));

X = load('herve001_labeled.txt');

Y = puissancelisse(X(:,1));