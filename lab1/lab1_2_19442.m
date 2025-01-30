clear all
close all
clc
%%
Fs=1000;
Ts=1/Fs;
T=0.1;
t=0:Ts:T-Ts;
A=1;
x=A*sin(2*pi*100*t);
L=length(x);
plot(t,x)
%title('Fs=1000')
pause
%%
N=2*L; %%N deigmata (mikos fourier transform) 2 fores to mikos tou simatos
Fo=Fs/N; %%analisi sixnotitas gia dianisma sixnotiton
Fx=fft(x,N);
freq=(0:N-1)*Fo;
plot(freq,abs(Fx))
title('FFT')
pause
axis([0 100 0 L/2]) %times 0 100 ston orizontio 0 L/2 ston katheto 
pause
%%
power = Fx.*conj(Fx)/Fs/L; %Pxx apo simeioseis, piknotita fasmatos isxios
plot(freq, power)
xlabel('Frequency (Hz)')
ylabel('Power')
title('{\bf Periodogram}')
%%
power_theory=A^2/2 %platos sto tetragono dia 2
dB=10*log10(power_theory)
power_time_domain=sum(abs(x).^2)/L
power_frequency_domain=sum(power)*Fo