function [ r] = autocorrelacion( x,L)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
N=length(x);
r=zeros(1,L+1);
for d=0:L
    sum=0;
    for i=1:N-d
        sum=sum+x(i)*x(i+d);
    end
    r1=sum/(N);
    r(1+d)=r1;
end
end

