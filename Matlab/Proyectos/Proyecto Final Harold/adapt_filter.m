function [s] = adapt_filter(signal_noise,reference_noise,u,initial_coefficients)
w=initial_coefficients;
retardos=zeros(1,length(w));
e=zeros(1,length(reference_noise));
s=zeros(1,length(reference_noise));
for n=1:length(reference_noise)
    retardos(1) = reference_noise(n);
    yn = 0;  
for i=1:length(w) 
    yn = yn+w(i)*retardos(i);
end
e(n)= signal_noise(n)-yn;
for i = 1: length(w)
    w(i) = w(i)+2*u*e(n)*retardos(i);
end
 for i = length(w):-1:2
 retardos(i) = retardos(i-1); 
 end
 
s(n)= yn;
end
s=signal_noise-s;
end

