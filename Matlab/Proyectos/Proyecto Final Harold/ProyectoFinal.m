 %%Cargar
load('reference_emg.mat');
load('noisy_ecg.mat');
ruido=reference_emg;
ecg=noisy_ecg;
fs=1000;


 %% 1.Creacion del Filtro FIR
n=10;
w=0.2;
b=fir1(n,w);
%r=coeficientes(w,n);
ruidof=filter(b,1,ruido);
f1=filter(b,1,ecg);
f2=fFIR(b,ecg);
frecuencia=paragraf(ecg);
ruidofi=paragraf(ruidof);
f11=paragraf(f1);
f22=paragraf(f2);
ruidoo=paragraf(ruido);
f=(-length(ecg)/2:(length(ecg)/2)-1)*(fs/length(ecg));
figure(1)
subplot(311),plot(f,abs(frecuencia)),title('Especto de Frecuencia señal original');xlabel('Frecuencia'), ylabel('Amplitud');
subplot(312),plot(f,abs(f11));title('Señal filtrada con Matlab');xlabel('Frecuencia'), ylabel('Amplitud');
subplot(313),plot(f,abs(f22));title('Señal filtrada con Funciones Creadas');xlabel('Frecuencia'), ylabel('Amplitud');
figure(2)
subplot(211),plot(f,abs(ruidoo)),title('Especto de Frecuencia Ruido original');xlabel('Frecuencia'), ylabel('Amplitud');
subplot(212),plot(f,abs(ruidofi));title('Ruido  filtrado ');xlabel('Frecuencia'), ylabel('Amplitud');

 %% 2.Filtro Adapatativo
u=0.015;
s=adapt_filter(f2,ruidof,u,b);
lms=dsp.LMSFilter(11,'Method','LMS','StepSize',u,'InitialConditions',b);
[a,e]=step(lms,ruidof',f2');
figure(1)
subplot(211),plot(e),title('Filtrado LMS con Matlab');xlabel('Tiempo'), ylabel('Amplitud');
subplot(212),plot(s),title('Filtrado LMS con adapt-filter');xlabel('Tiempo'), ylabel('Amplitud');
%% 3 DSP
Swelch=pwelch(ecg,200);
fs2=(-length(Swelch)/2:(length(Swelch)/2)-1)*(fs/length(Swelch));
Swelch=fft(Swelch);
Swelch=fftshift(Swelch);
figure(1)
p=welch(ecg,200,50);
p1=welch(f2,200,50);
p2=welch(s,200,50);
p1=fft(p1);
p1=fftshift(p1);
p2=fft(p2);
p2=fftshift(p2);
fs1=(-length(p)/2:(length(p)/2)-1)*(fs/length(p));
p=fft(p);
p=fftshift(p);
figure(1)
subplot(211),plot(fs2,Swelch),title('D con Matlab(Welch)');xlabel('Frecuencia'), ylabel('Amplitud');
subplot(212),plot(fs1,p),title('D con welch');xlabel('Frecuencia'), ylabel('Amplitud');
figure(2)
plot(fs1,p,fs1,p1,fs1,p2);xlabel('Frecuencia'), ylabel('Amplitud');legend('Original','Filtrado Pasabajo','Filtrado LMS');
%% Dsp Yule
q=11;
rx=autocorrelacion(ecg,q);
Rx=toeplitz(rx(1:q));
a=inv(Rx)*(-rx(2:q+1)');
bo=rx(1)+rx(2:q+1)*a;
[yw,w]=arpds(bo,a,ceil((length(ecg))/2));
f=w*fs/(2*pi);
yw=fft(yw);
yw=fftshift(yw); 
figure(1)
plot(f,yw),title('Estimacion Yule Walker');
%% Durvin
rx=xcorr(ecg,10);
rx=rx(11:end);
[a1,e1]=durvin(rx);
[a2,e2]=levinson(rx);
b1=sqrt(e1);
b2=sqrt(e2);
[d1,w]=arpsdmodifc(b1,a1,128);
[d2,w]=arpsdmodifc(b2,a2,128);
f=w1*fs/(2*pi);
figure(1)
subplot(211),plot(w,d1),title('Durvin con Funcion');xlabel('Frecuencia'), ylabel('Amplitud');
subplot(212),plot(w,d2),title('Durvin con Matlab');xlabel('Frecuencia'), ylabel('Amplitud');
% [p,w]=DurvinEntero(ecg);
% [p1,w]=DurvinEntero(s);
% [p2,w]=DurvinEntero(f2);
% figure(2)
% plot(w,p,w,p1,w,p2);xlabel('Frecuencia'), ylabel('Amplitud');legend('Original','Filtrado Pasabajo','Filtrado LMS');
