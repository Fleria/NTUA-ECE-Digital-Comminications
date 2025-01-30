%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all 
clc 
Fs=2000; 
Ts=1/Fs;
L=2000; 
T=L*Ts; 
t=0:Ts:(L-1)*Ts; 
x=sin(2*pi*100*t)... 
+ 0.3*sin(2*pi*150*(t-2))... 
+ sin(2*pi*200*t); 

figure(1) 
plot(t,x) 
title('Time domain plot of x') 
xlabel('t (sec)') 
ylabel('Amplitude') 
axis([0 0.3 -2 2]) 
pause 

N = 2^nextpow2(L); 
Fo=Fs/N; 
f=(0:N-1)*Fo; 
X=fft(x,N); 
figure(2) 
plot((f(1:N)),abs(X(1:N))) 
title('Frequency domain plot of x') 
xlabel('f (Hz)')
ylabel('Amplitude') 
pause 

figure(3) 
fnew=f-Fs/2; 
X=fftshift(X); 
plot(fnew,abs(X));title('Two sided spectrum of x'); 
xlabel('f (Hz)');
ylabel('Amplitude')
pause 

power=X.*conj(X)/N/L; %%ipologizoume piknotita fasmatos isxios
figure(4) 
plot(fnew,power) 
xlabel('Frequency (Hz)')
ylabel('Power') 
title('{\bf Periodogram}') 
pause
%%
disp('Part2')
si=size(x);
n=randn(si);
figure(5)
plot(t,n)
title('Time domain plot of noise')
xlabel('t(sec)')
ylabel('Amplitude')
axis([0 0.3 -2 2])
pause

Fn=fft(n,N);
powern = Fn.*conj(Fn)/Fs/L;
figure(6)
plot(f, powern)
xlabel('Frequency (Hz)') 
ylabel('Noise Power') 
title('{\bf Noise Periodogram}') 
pause

s=x+n;
figure(7)
plot(t,s)
title('Time domain plot of s')
xlabel('t(sec)')
ylabel('Amplitude')
axis([0 0.3 -2 2])
pause

Fs=fft(s,N);
Fs=fftshift(Fs);
figure(8)
plot(fnew, abs(Fs))
title('Two sided spectrum of s')
xlabel('f(Hz)');
ylabel('Amplitude')
pause

%%
disp('Part3')
p=sin(2*pi*700*t);
m=p.*s;
figure(8)
plot(t,m)
title('Time domain plot of m')
xlabel('t(sec)')
ylabel('Amplitude')
axis([0 0.3 -2 2])
pause

Fm=fft(m,N);
Fm=fftshift(Fm);
figure(9)
plot(fnew,abs(Fm))
title('Two sided spectrum of m')
xlabel('f (Hz)')
ylabel('Amplitude')