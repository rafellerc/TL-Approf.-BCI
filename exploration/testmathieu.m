addpath(genpath('\\ntelev.metz.supelec.centralesupelec.local\Users\daviet_mat\WINNT\Desktop\TLAppro\acquisition_biosemi\Enregistrements'));

filename = 'herve001.txt';
load(filename);
fe  = 256;
fenetrage = 1.4;
pas=0.1;
data = herve001(:,1);
lwindow = int16(fe*fenetrage);
lpas = int16(fe *  pas)

for i=1:(length(data)-2*lwindow)/lpas-1
    newdata = data(lwindow+lpas*(i-1):2*lwindow + lpas*(i-1));
    [pxx,f] = periodogram(newdata(:,1));
    f = f*fe/2/pi;
    
    debfreq1 = max(find(f <= 7));
    finfreq1 = max(find(f <= 8));
    debfreq2 = max(find(f <= 10.5));
    finfreq2 = max(find(f <= 11.5));
    debfreq3 = max(find(f <= 13));
    finfreq3 = max(find(f <= 14));
    ampfreq1(i) = 0;
    ampfreq2(i) = 0;
    ampfreq3(i) = 0;
    for k = debfreq1:finfreq1
        ampfreq1(i) = ampfreq1(i) + pxx(k);
    end
    ampfreq1(i) = ampfreq1(i)/(debfreq1-finfreq1+1);
    for k = debfreq2:finfreq2
        ampfreq2(i) = ampfreq2(i) + pxx(k);
    end
    ampfreq2(i) = ampfreq2(i)/(debfreq2-finfreq2+1);
    for k = debfreq3:finfreq3
        ampfreq3(i) = ampfreq3(i) + pxx(k);
    end
    ampfreq3(i) = ampfreq3(i)/(debfreq3-finfreq3+1);
    axet = double(lwindow/2 + lpas * (i-1));
    axe(i) = (axet)/fe;
end


plot(axe, ampfreq2);
