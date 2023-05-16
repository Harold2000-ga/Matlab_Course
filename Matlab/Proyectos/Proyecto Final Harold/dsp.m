function [dsp] = dsp( a,w )
w=w.*sqrt(length(a)/sum(w.^2));
dsp=(abs(fft(a.*w)).^2)/length(a);
dsp=dsp(1:length(a)/2);
end
