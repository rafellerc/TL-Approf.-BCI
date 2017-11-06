%addpath(genpath('C:\Users\Rafael\sir\acquisition_biosemi\Enregistrements\'));
load('herve001.txt');
Fs = 256;
Ts = 1/Fs;
data_Length = length(herve001);
T = Ts*([1:data_Length]-1)';
x = herve001(:,1);

% [S,F,T] = spectrogram(x,1024,0,1024,Fs,'yaxis');
% pcolor(T,F(1:100),10*log10(abs(S(1:100,:))));shading flat
% xlabel('Time (s)');ylabel('Frequency (Hz)')
% [Smax, I] = max(abs(S),[],1);
NFFT = data_Length;
[Pxx,F] = pwelch(x,ones(data_Length,1),0,NFFT,Fs);

Hpsd = figure(3);clf
plot(F,20*log(Pxx));axis tight
xlabel('Freq');ylabel('PSD Welch')