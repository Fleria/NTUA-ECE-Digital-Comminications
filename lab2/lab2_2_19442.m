%% Meros 3
clear all; close all; clc;
load sima;
%Fs=8192; 
f1=600; f2=2000;
T=1; Ts=1/Fs; t=0:Ts:T-Ts;
figure; pwelch(s,[],[],[],Fs);
pause

H=[zeros(1,600) ones(1,2000-600) zeros(1,Fs-2000)]; %idaniki vathiperati sinartisi
h=ifft(H,'symmetric'); %kroustiki apokrisi
middle=length(h)/2; 
h=ifftshift(h); %to ftiaxnoume
h128=h(middle+1-64:middle+65); %dialegoume parathiro 128

%dimiourgoume hamming, kaiser ta kai plotaroume 
wh=hamming(length(h128));
wk=kaiser(length(h128),5);
figure; plot(0:128,wk,'r',0:128,wh,'b'); grid; title('hamming and kaiser windows');
pause

h_hamming=h128.*wh'; %dimiourgia filtron
h_kaiser=h128.*wk';
wvtool(h128,h_hamming,h_kaiser); %sigkrisi me apli kommeni apokrisi sixnotitas kroustikis apokrisis
pause
y_rect=conv(s,h128);
figure; pwelch(y_rect,[],[],[],Fs); title('pwelch orthogoniko');
pause
y_hamm=conv(s,h_hamming);
figure; pwelch(y_hamm,[],[],[],Fs); title('pwelch hamming');
pause
y_kais=conv(s,h_kaiser);
figure; pwelch(y_kais,[],[],[],Fs); title('pwelch kaiser');
pause

%Parks-McClellan
f=2*[0 600*0.95 600*1.05 2000*0.95 2000*1.05 Fs/2]/Fs;
hbp_pm=firpm(128, f, [0 0 1 1 0 0]);
% figure; freqz(hpm,1);
wvtool(hbp_pm);
pause
sima_bp=conv(s,hbp_pm);
figure; pwelch(sima_bp,[],[],[],Fs); title('pwelch parks-mcclellan');
pause
sound(20*s); 
pause
sound(20*sima_bp);
pause
