function [prediction] = commande(entree, threesold ,delta_f, G)

fe = 256;
fc_1 = 7.5;
fc_2 = 11;
fc_3 = 13.5;

[Y1] = filtre(entree,G,delta_f,fe,fc_1);
[Y2] = filtre(entree,G,delta_f,fe,fc_2);
[Y3] = filtre(entree,G,delta_f,fe,fc_3);

prediction = zeros(length(Y1),1);

for i = 36:length(Y1)
    est_amp_1 = max(abs(Y1(i-35:i)));
    est_amp_2 = max(abs(Y2(i-35:i)));
    est_amp_3 = max(abs(Y3(i-35:i)));

    
    
    if(est_amp_1<threesold && est_amp_2<threesold && est_amp_3<threesold)
        prediction(i) = 0;
    elseif(est_amp_1>est_amp_2 && est_amp_1>est_amp_3)
        prediction(i) = 3;
    elseif(est_amp_2>est_amp_1 && est_amp_2>est_amp_3)
        prediction(i) = 1;
    else
        prediction(i) = 2;
    end
end
 

end