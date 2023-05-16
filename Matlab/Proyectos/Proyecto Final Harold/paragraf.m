function [y] = paragraf( x )
x=fft(x);
y=fftshift(x);

end

