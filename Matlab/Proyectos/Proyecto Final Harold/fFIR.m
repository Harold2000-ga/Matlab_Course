 function [ c ] = fFIR( a,x)
retardos=zeros(1,length(a));
c=zeros(1,length(x));
for n=1:length(x)
    retardos(1)=x(n);
    suma=0;
    for i=1:length(a)
        suma=suma+retardos(i)*a(i);
    end
    c(n)=suma;
    for i=length(retardos):-1:2
      retardos(i)=retardos(i-1); 
    end  
end
end

