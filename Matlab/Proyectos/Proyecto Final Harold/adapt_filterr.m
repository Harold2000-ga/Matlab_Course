function [s] = adapt_filterr(signal_noise,reference_noise,u,initial_coefficients)
w = initial_coefficients;
delay=zeros(length(reference_noise));

for m=1:length(reference_noise)
    delay(1)=reference_noise(m);
    y =0;
for i=1:length(initial_coefficients)
%Se filtra la señal de referencia con los coeficientes actuales    
        y(i)=w(i)*delay(i);
%Calculo del error
    e(i)= signal_noise(i)-y(i);
end
%Obtencion de nuevos coeficientes
    for i=length(w):-1:2
         w(i) = w(i)+2*u*e(i)*reference_noise(i);
         delay(i)=delay(i-1);
    end
end

    s=signal_noise-y;
end


