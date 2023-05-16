function [ c ] = Untitled3(a,x )

r=length(x);
s=length(a);
valor=zeros(1,s);
c=zeros(1,r);
for n=1:r
    valor(1)=x(n);
    suma=0;
 for i=1:length(a)
        suma=suma+valor(i)*a(i);
 end
end

