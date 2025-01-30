clear all;
close all;
clc;

k=3;
L=2^k;
EbNoNum=0:18;  
EbNo=10.^(EbNoNum/10); %se dB
%theoritikos ipologismos Pe, BER
Pe=(L-1)/L*erfc(sqrt(3*log2(L)/(L^2-1)*EbNo)); %sxesi 3.33 gia pithanotita esfalmenou simvolou
BER=Pe/k;

for i=1:length(EbNoNum)
   errors(i)=ask_errors1(k,20000,16,EbNoNum(i)); %epistrefei ta errors gia kathe EbNo
end

Pe_new=errors/20000;
BER_new=Pe_new/k;

figure(1);
semilogy(EbNoNum,BER,"r",EbNoNum,BER_new,'*')
axis ([0 18 10^(-6) 10^0]);
grid on;