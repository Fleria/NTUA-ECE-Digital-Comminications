k=3;
%k=4;
L=2^k;
EbNo=0:18;
EBNO=10.^(EbNo/10);
Petheoretical=(L-1)/L*erfc(sqrt(3*k/(L^2-1)*EBNO));
BERtheoretical=Petheoretical/k;
nsamp=16;
delay = 10;
filtorder = delay*nsamp*2;
rolloff = 0.9;

%disp(EBNO);
errors = zeros(1,18);
for i=1:length(EbNo)
    errors(i)=lab4_3_19442help(k,10000,16,EbNo(i));
end
Penew = errors/10000;
BERnew=Penew/k;

figure(1);
semilogy(EbNo,BERtheoretical,"r",EbNo,BERnew,"*");
title("BER figure");
ylabel("BER");
xlabel("Eb/N0 (dB)");
legend("theoretical","simulation");