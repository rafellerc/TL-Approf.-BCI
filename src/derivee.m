function [d] = derivee(fe,k,Y)
for n=1:k
    d(n,:)=0;
end
for n=k+1:length(Y)
    d(n,:) = (fe/k)*(Y(n)-Y(n-k));
end
end

