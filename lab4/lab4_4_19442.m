function errors=lab4_4_19442(k,Nsymb,nsamp,EbNo)
%parametroi
delay = 16;
filtorder = delay*nsamp*2;
rolloff = 0.32;

L=2^k;
step=2;
SNR=EbNo-10*log10(nsamp/2/k);
x=round(rand(1,Nsymb*k));
mapping=[step/2; -step/2];
if(k>1)
 for j=2:k
 mapping=[mapping+2^(j-1)*step/2; -mapping-2^(j-1)*step/2];
 end
end
xsym=bi2de(reshape(x,k,length(x)/k).','left-msb');
y=[];
for i=1:length(xsym)
 y=[y mapping(xsym(i)+1)];
end

rNyquist= rcosine(1,nsamp,'fir/sqrt',rolloff,delay);
y=upsample(y,nsamp);
ytx = conv(y,rNyquist);
ynoisy=awgn(ytx,SNR,'measured');
yrx=conv(ynoisy,rNyquist);
yrx = yrx(2*delay*nsamp+1:end-2*delay*nsamp);
yr = downsample(yrx,nsamp);
xr=[];
for i=1:length(yr)
    [m,j]=min(abs(mapping-yr(i)));
    xr=[xr de2bi(j-1,k,'left-msb')];
end
err=not(x==xr);
errors=sum(err);
end