function [prediction_ts] = commande_ts(prediction,t)

prediction_ts = zeros(length(prediction) ,1);


% for i = 1 : length(prediction)-256*t-1
A=1;
i=1;
while(A < length(prediction_ts))
    i=A;
    if prediction(i)==prediction(i+1)
        cpt=0;
        m=prediction(i);
        while (i+cpt+1<length(prediction) && prediction(i)==prediction(i+cpt+1) && cpt<=256*t )
            cpt = cpt+1;
        end
        A=A+cpt;
        if cpt == 256*t
            m =prediction(i);
            for n =i:i+cpt
                prediction_ts(n) = prediction(i);
            end
        else
            for n = i : i+cpt
            prediction_ts(n) = m;
            end
        end
        
    else 
        it=2;
        while (i+it < length(prediction) && prediction(i+1)==prediction(i+it))
            it=it+1;
        end
        A=A+it;
        if it < 256*t-2
            for n =i:i+it-2
                prediction_ts(n)=prediction(i);
            end
        else
            for n =i:i+it-2
                prediction_ts(n)=prediction(i+1);
            end
        end
   end
end

    
    
    
    
%     if cpt >= 256*t
%         cpt2=cpt;
%         m =prediction(i);
%         prediction_ts(i) = prediction(i);
%     else
%         for n = i : i+cpt2
%             prediction_ts(n) = m;
%         end
%     end
%     cpt=0;
end

    
