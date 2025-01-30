%% Meros 2
clear all; close all; clc;
load sima;
figure; pwelch(s,[],[],[],Fs); title('Pwelch of s');
H=[ones(1,Fs/8) zeros(1,Fs-Fs/4) ones(1,Fs/8)]; %i idaniki vathiperati sinartisi
h=ifft(H, 'symmetric');
h=ifftshift(h); %%ipologismos kroustikis apokrisis me antistrofo fourier
middle=length(h)/2;
h32=h(middle+1-16:middle+17); %%perikopi tis kroustikis apokrisis se diafora miki
h64=h(middle+1-32:middle+33);
h128=h(middle+1-64:middle+65);
wvtool(h32,h64,h128); % apokriseis sixnotitas ton perikomenon h. polloi pleurikoi lovoi
pause
wh=hamming(length(h64));
wk=kaiser(length(h64),5);
figure; plot(0:64,wk,'r',0:64,wh,'b'); title ('hamming, kaiser windows'); grid; %plot ta parathira hamming, kaiser
h_hamming=h64.*wh';%kroustiki apokrisi me parathiro --> dimiourgia filtrou
% figure; stem([0:length(h64)-1],h_hamming); grid;
% figure; freqz(h_hamming,1);
h_kaiser=h64.*wk'; %kroustiki apokrisi me parathiro
wvtool(h64,h_hamming,h_kaiser); %apokriseis sixnotitas ton filtron se sxesi me perikommeni kroustiki apokrisi
pause
%convolution tou simatos me ta filtra
y_rect=conv(s,h64);
figure; pwelch(y_rect,[],[],[],Fs); title ('Pwelch rectangle')
pause
y_hamm=conv(s,h_hamming);
figure; pwelch(y_hamm,[],[],[],Fs); title ('Pwelch Hamming')
pause
y_kais=conv(s,h_kaiser);
figure; pwelch(y_kais,[],[],[],Fs); title ('Pwelch Kaiser')
pause
%
% Parks-MacClellan
hpm=firpm(64, [0 0.10 0.15 0.5]*2, [1 1 0 0]); %kataskeui filtrou
% figure; freqz(hpm,1);
s_pm=conv(s,hpm);
figure; pwelch(s_pm,[],[],[],Fs); title ('Pwelch Parks-McClellan')
pause
sound(20*s); % ?????? ?? ?????? ????, s
pause
sound(20*s_pm); % ?????? ?? ????????????? ????, s_lp?
pause

%% Mikos 196+1 rectangle kai hamming
h196=h(middle+1-98:middle+99);
wh196=hamming(length(h196));
h196_hamming=h196.*wh196';
wvtool(h196,h196_hamming); %apokrisis sixnotitas me orthogoniko kai hamming
y_196=conv(s,196);
figure; pwelch(y_196,[],[],[],Fs); title('196 rectangle')
pause
y_hamm196=conv(s,h196_hamming);
figure; pwelch(y_hamm196,[],[],[],Fs); title('196 hamming')
pause
%% Parks-McClellan mikous 196+1
hpm196=firpm(196, [0 0.10 0.15 0.5]*2, [1 1 0 0]);
s_pm196=conv(s,hpm196);
wvtool(hpm,hpm196);
figure; pwelch(s_pm196,[],[],[],Fs); title ('Pwelch Parks-McClellan length 196 freq 0.1, 0.15')
pause
sound(20*s); 
pause
sound(20*s_pm196); 
%% nees oriakes sixnotites 0.11-0.12
hpm196b=firpm(196, [0 0.11 0.12 0.5]*2, [1 1 0 0]);
s_pm196b=conv(s,hpm196b);
wvtool(hpm,hpm196b);
figure; pwelch(s_pm196b,[],[],[],Fs); title ('Pwelch Parks-McClellan freq 0.11, 0.12') %de ginetai toso kali apokopi
pause
sound(20*s); 
pause
sound(20*s_pm196b); 
%% imitoniko sima (ola me mikos 196)
Fs=8192; T=1; Ts=1/Fs; t=0:Ts:T-Ts;
signal = sin(2*pi*800*t)+sin(2*pi*3000*t)+sin(2*pi*2000*t)+sin(2*pi*1000*t);
plot(t,signal); title('sin signal time');

H=[ones(1,Fs/8) zeros(1,Fs-Fs/4) ones(1,Fs/8)];
h=ifft(H,'symmetric');
middle=length(h)/2;
h=ifftshift(h);
h196=h(middle+1-98:middle+99);
figure; pwelch(signal,[],[],[],Fs); title('Pwelch sin signal');

hpm196=firpm(196, [0 0.10 0.15 0.5]*2, [1 1 0 0]);
signal_pm196=conv(signal,hpm196);
figure; pwelch(signal_pm196,[],[],[],Fs); title ('Pwelch Parks-McClellan 0.1, 0.15 of sin')
pause

hpm196b=firpm(196, [0 0.11 0.12 0.5]*2, [1 1 0 0]);
signal_pm196b=conv(signal,hpm196b);
figure; pwelch(signal_pm196b,[],[],[],Fs); title ('Pwelch Parks-McClellan 0.11, 0.12 of sin')