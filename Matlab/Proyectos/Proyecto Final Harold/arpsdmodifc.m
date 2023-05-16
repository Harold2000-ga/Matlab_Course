function [ px,f_px ] = arpsdmodifc( g,a,n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

a=a(2:length(a));
a=-a;
Fs=1000;

px=zeros(1,n);
w=linspace(0,pi,n);

for i=1:length(w)
    re=0; im=0;
    
    for k=1:length(a)
        re=re-a(k)*cos((k)*w(i));
        im=re-a(k)*sin((k)*w(i));
    end
    re=re+1;
    sum=re.^2+im.^2;
    px(i)=g/sum;
    
end
px=abs(fft(px))/length(px);
px=fftshift(px.^2);
L1=ceil(length(px)/2);
f_px=linspace(-L1,L1,length(px))*(Fs/length(px));


end

