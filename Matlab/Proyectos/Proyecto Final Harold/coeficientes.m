function [coef ] = coeficientes(fc,n)
M=n+1;
coef=zeros(1,M);
window=hanning(M);
%k=1/8;
for i=1:M
    if(i==M/2)
        coef(i)=pi*fc;
        continue
    end
    coef(i)=(sin(pi*fc*(i-M/2))/(i-M/2).*window(i));
end

