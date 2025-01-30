function errors=ask_Nyq_filter(k,Nsymb,nsamp,EbNo)
%gia 16-ASK theloume k=4
k=4;
L=2^k;
nsamp=16;
Nsymb=2500;
step=2;
SNR=EbNo-10*log10(nsamp/2/k); % SNR ana deigma simatos
% dianisma tixaion akeraion apo to sinolo {±1, ±3, ... ±(L-1)}
x=round(rand(1,Nsymb*k));
%kodikopoiisi kata Gray. ftiaxnoume to mapping opos sto sxima kai to
%sisxetizoume me y
mapping=[step/2; -step/2];
%disp(mapping);
if(k>1)
 for j=2:k
 mapping=[mapping+2^(j-1)*step/2; -mapping-2^(j-1)*step/2];
 end
end
%disp(mapping);
xsym=bi2de(reshape(x,k,length(x)/k).','left-msb'); %kanei to binary decimal
%disp(xsym);
y=[];
for i=1:length(xsym)
 y=[y mapping(xsym(i)+1)];
end
%disp(y);
%% orismos parametron filtrou
delay = 4; % Group delay (# of input symbols). gia taksi filtrou 128 delay=4
filtorder = delay*nsamp*2; % taksi filtrou
rolloff = 0.35; % sintelestis ptosis -- rolloff factor
% kroustiki apokrisi filtrou tetr. rizas anips. cos
rNyquist= rcosine(1,nsamp,'fir/sqrt',rolloff,delay);
% ----------------------
% I epomeni entoli gia filtro grammikis ptosis
% (rtrapezium tou kodika 4.1 sto current directory)
% delay>5 
% rNyquist=rtrapezium(nsamp,rolloff,delay);
% ----------------------
%% ekpempomeno sima
% iperdeigmatisi kai efarmogi filtrou rNyquist
y=upsample(y,nsamp);
ytx = conv(y,rNyquist);
% eyediagram gia meros filtrarismenou simatos
% eyediagram(ytx(1:2000),nsamp*2);
%ynoisy=awgn(ytx,SNR,'measured'); % ????????? ????
% ----------------------
%% lamvanomeno sima
% filtrarisma simatos me filtro tetr. rizas anips. cos
yrx = conv(ytx,rNyquist); 
yrx = yrx(2*delay*nsamp+1:end-2*delay*nsamp); % perikopi, logo kathisterisis
yr = downsample(yrx,nsamp);
% anixneutis elaxistis apostasis L platon
l=[-L+1:2:L-1];
for i=1:length(yrx)
[m,j]=min(abs(l-yrx(i)));
end
figure(); 
plot(yrx(1:10*nsamp));
figure; 
hold on; 
plot(yrx(1:10*nsamp)); 
stem(0:nsamp:10*nsamp,y(1:nsamp:10*nsamp+1)); 
hold off;
figure();
pwelch(yrx);