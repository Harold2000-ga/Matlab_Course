function [ c] = welch(x,L,S)
n=length(x);
R=floor(n/(L-S));
w=hamming(L);
c=0;
for i=0:R-2
c=c+(abs(fft(x(i*(L-S)+1:i*(L-S)+L)*w(i+1))).^2)./L;
end
c=c/(R-2);
end

