function errors=lab3_3_19442(k,Nsymb,nsamp,EbNo)
d=3;
L=2^k;
SNR=EbNo-10*log10(nsamp/2/k); 
x=(2*floor(L*rand(1,Nsymb))-L+1)*d/2;
Px=(L^2-1)/3; 
sum(x.^2)/length(x);

h=ones(1,nsamp); %orthogonikos palmos
%h=cos(2*pi*(1:nsamp)/nsamp); 
h=h/sqrt(h*h');
%stem(h);

y=upsample(x,nsamp); 
y=conv(y,h);  %pros ekpompi sima
y=y(1:Nsymb*nsamp); 
ynoisy=awgn(y,SNR,'measured');
%ynoisy = y;

for i=1:nsamp 
    matched(i)=h(end-i+1); 
end

matched=h;
yrx=conv(ynoisy,matched);
z = yrx(nsamp:nsamp:Nsymb*nsamp); 
A=[(-L+1)*d/2:d:(L+1)*d/2];
%A=[-L+1:2:L-1];
%figure; stem(x(1:20));
%figure; stem(y(1:20*nsamp));
%figure; stem(yrx(1:20*nsamp));
%figure; stem(h);

for i=1:length(z)
   [m,j]=min(abs(A-z(i)));
   z(i)=A(j);
end
err=not(x==z);
errors=sum(err);
 end
