function errors=ask_errors(k,Nsymb,nsamp,EbNo, d)
% k = mod(19442,2) + 3 = 0+3 = 3
% d i apostasi ton simeion
% nsamp # deigmaton sti diarkeia T enos palmou
L=2^k;
SNR=EbNo-10*log10(nsamp/2/k); 
x=d/2*(2*floor(L*rand(1,Nsymb))-L+1); %dianisma simvolon

Px=(L^2-1)/3; %theoritiki isxis
sum(x.^2)/length(x); %metroumeni isxis

y=rectpulse(x,nsamp); %sima apo palmous apo ta simvola
n=wgn(1,length(y),10*log10(Px)-SNR); %prosthiki thorivou
ynoisy=y+n; 
y=reshape(ynoisy,nsamp,length(ynoisy)/nsamp);
matched=ones(1,nsamp); %neos pinakas
z=matched*y/nsamp; %sisxetisi tou y me to prosarmosmeno filtro
A=[(-L+1)*d/2:d:(L-1)*d/2]; %dianisma L diaforask_eretikon timon ton akeraion simvolon
%disp(A);
%figure(1)
%hist(x,A);
hist(z,200);
%pause
for i=1:length(z)
    [m,j]=min(abs(A-z(i)));
    z(i)=A(j);
end
err=not(x==z); %ginetai 1 an to z den tautizetai me to arxiko x
errors=sum(err);
end
