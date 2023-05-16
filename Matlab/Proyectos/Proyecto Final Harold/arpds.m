function [p,w] = arpds(g,cof,n)
p=zeros(1,n);
w=linspace(0,pi,n);
for m=1:length(w)
    sum=0;
    for k=1:length(cof)
        sum=sum+cof(k)*exp(1i*(k)*w(m));
    end
    sum=sum+1;
    p(m)=g/(abs(sum).^2);
end

end

