%On calcule la prediction corrigée (prédiction_ts) : c'est la prédiction
%telle qu'un ordre donné pendant moins de t (t en s) ne sera pas considéré
%comme valide

function [prediction_ts] = commande_ts(prediction,t)

prediction_ts = zeros(length(prediction) ,1);

A=1;
i=1;

%On prend les échantillons du signal les uns à la suite des autres 
while(A < length(prediction_ts))
    i=A;
    %si l'ordre est tenu d'un échantillon au suivant
    if prediction(i)==prediction(i+1)
        cpt=0;
        m=prediction(i);
        %tant que l'ordre est tenu, on incrémente un compteur cpt jusqu'à
        %ce que l'ordre ait été tenu pendant au moins t
        while (i+cpt+1<length(prediction) && prediction(i)==prediction(i+cpt+1) && cpt<=256*t )
            cpt = cpt+1;
        end
        %On incrémente A, pour se déplacer le long des échantillons
        A=A+cpt;
        %si le compteur atteint t*256, l'ordre est considéré comme valide
        if cpt == 256*t
            m =prediction(i);
            for n =i:i+cpt
                prediction_ts(n) = prediction(i);
            end
        %si le compteur n'atteint pas t*256, l'ordre est considéré comme
        %ne changeant pas
        else
            for n = i : i+cpt
            prediction_ts(n) = m;
            end
        end
    %si l'ordre est différent d'un échantillon à l'autre, on incrémente 
    %un nouveau compteur donnant la longueur du nouvel ordre
    else 
        it=2;
        while (i+it < length(prediction) && prediction(i+1)==prediction(i+it))
            it=it+1;
        end
        %On incrémente A pour se déplacer le long des échantillons
        A=A+it;
        % Si le nouvel ordre n'est pas tenu 256*t, il est considéré comme 
        %non valide et n'apparaît pas dans la prédiction corrigée
        if it < 256*t-2
            for n =i:i+it-2
                prediction_ts(n)=prediction(i);
            end
        %Si le nouvel ordre est tenu au moins 256*t, il est considéré comme 
        %valide et apparaît dans la prédiction corrigée
        else
            for n =i:i+it-2
                prediction_ts(n)=prediction(i+1);
            end
        end
   end
end

end

    
