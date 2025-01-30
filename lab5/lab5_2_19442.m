function errors=psk_errors(k,Nsymb,nsamp,EbNo)
bR = 1550000; %baud Rate 1/T=1.55MHz
M=2^k;
fc=5;
rolloff=0.29;
delay=10;
filtorder = delay*nsamp*2;
SNR=EbNo-10*log10(nsamp/k/2);

%gray coding
mapping=mapping_gray(k);
x=floor(2*rand(k*Nsymb,1)); 
xsym=bi2de(reshape(x,k,length(x)/k).','left-msb')';
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


Ps=10*log10(s*s'/length(s)); %isxis simatos
Pn=Ps-SNR; %isxis thorivou
n=sqrt(10^(Pn/10))*randn(1,length(ytx));
snoisy=s+n; 

yrx = 2*snoisy.*exp(-1j*2*pi*fc*m/nsamp); %to idio apo pano alla me noisy
yrx = conv(yrx,rNyquist);
yrx = downsample(yrx,nsamp);
yrx = yrx(2*delay+(1:length(y))); %perikopi akron sineliksis

xrx=[]; %binary exit vector
q=[0:1:M-1];
lr=real(mapping);
li=imag(mapping);
for p=1:length(yrx) %epilogi plisiesterou simeiou
    [m,j]=min(abs(angle(mapping)-angle(yrx(p))));
    yrx(p)=q(j);
    xrx=[xrx; de2bi(q(j),k,'left-msb')'];
end
errors=sum(not(xrx==x));