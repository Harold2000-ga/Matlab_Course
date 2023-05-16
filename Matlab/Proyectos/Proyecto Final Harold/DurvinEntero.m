function [y,w] = DurvinEntero( x)
rx=xcorr(x,10);
rx=rx(11:end);
[a1,e1]=levinson(rx);
b1=sqrt(e1);
[y,w]=arpsdmodifc(b1,a1,128);

end

