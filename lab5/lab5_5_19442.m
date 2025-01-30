function errors=qam_errors(k,Nsymb,nsamp,EbNo)
M=2^k; L=sqrt(M);
fc=5;
rolloff=0.29;
delay=10;
l=log2(L); M=L^2;
filtorder = delay*nsamp*2;
SNR=EbNo-10*log10(nsamp/k/2);

x=floor(2*rand(k*Nsymb,1)); 
xsym=bi2de(reshape(x,k,length(x)/k).','left-msb')';

%gray coding
core=[1+1i;1-1i;-1+1i;-1-1i];
mapping=core;
if(l>1)
    for j=1:l-1
        mapping=mapping+j*2*core(1);
        mapping=[mapping;conj(mapping)];
        mapping=[mapping;-conj(mapping)];
    end
end

y=[];
for n=1:length(xsym)
    y=[y mapping(xsym(n)+1)];
end

rNyquist=rcosine(1,nsamp,'fir/sqrt',rolloff,delay);
ytx=upsample(y,nsamp); 
ytx=conv(ytx,rNyquist);

m=(1:length(ytx));
s=real(ytx.*exp(1j*2*pi*fc*m/nsamp));
figure(1); pwelch(s,[],[],[],nsamp); 

Ps=10*log10(s*s'/length(s)); 
Pn=Ps-SNR; 
n=sqrt(10^(Pn/10))*randn(1,length(ytx));
snoisy=s+n;

yrx=2*snoisy.*exp(-1j*2*pi*fc*m/nsamp);
yrx=conv(yrx,rNyquist);
yrx = downsample(yrx,nsamp);
yrx = yrx(2*delay+(1:length(y)));

yi=real(yrx); yq=imag(yrx); 
q=[-L+1:2:L-1];
for n=1:length(yrx) 
    [m,j]=min(abs(q-yi(n)));
    yi(n)=q(j);
    [m,j]=min(abs(q-yq(n)));
    yq(n)=q(j);
end
errors=sum(not(y==(yi+1i*yq)));