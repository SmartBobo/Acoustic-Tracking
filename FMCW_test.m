clc;
clear;

load('C:\Users\Bobo\Documents\WeChat Files\zhaoxinbo1185\FileStorage\File\2020-11\fmcw201130-162725.mat');
bandwidth = 6000;
f0 = 17500;
fs = 48000;
time = 0.045;
t = 1/fs:1/fs:0.045;

fmcw_sig = reshape(sin(2*pi*(f0+bandwidth/(2*time)*t).*t),2160,1);
ref_sig = reshape(sin(2*pi*f0*(-t)+2*pi*bandwidth/(2*time)*(-t.^2)),2160,1);
tx_sig = [];
for i = 1:400
    tx_sig = [tx_sig;fmcw_sig;zeros(240,1)];
end
tx_sig = reshape(tx_sig,960000,1);
rx_sig1 = awgn(0.9*circshift(tx_sig,216) + 0.3*circshift(tx_sig,648) + 0.1*circshift(tx_sig,432),10);
rx_sig2 = rx_sig1(1:2160).*ref_sig;
t_i = time*0.1;
test_sig = reshape(sin(2*pi*(bandwidth/time*t_i*t+f0*t_i-bandwidth/(2*time)*t_i*t_i)),2160,1);

%=======================查看相关性========================================
[r,lags] = xcorr(R1(100008:102167),fmcw_sig);
stem(lags,r);
%========================fft找峰值========================================
% pks_loc = [];
% for i = 1:50
%     L = 2160;
%     Y = fft(R1(300001+(i-1)*2160:300000+i*2160).*ref_sig);
%     Y = fft(test_sig(1:L));
%     P2 = abs(Y/L);
%     P1 = P2(1:L/2+1);
%     P1(2:end-1) = 2*P1(2:end-1);
%     [PKS,LOCS]= findpeaks(P1,'MinPeakHeight',0.1);
%     pks_loc = [pks_loc;LOCS];
%     f = fs*(0:(L/2))/L;
%     figure;
%     plot(f,P1) 
%     title('Single-Sided Amplitude Spectrum of FMCW Received Signal')
%     xlabel('f (Hz)')
%     ylabel('|P1(f)|')
% end


%====================滤波器============================================
% [pks,locs] = findpeaks(P1,f,'MinPeakProminence',0.04);
% filt_fre = locs(1);
% bpFilt = designfilt('bandpassfir','FilterOrder',30, ...
%          'CutoffFrequency1',filt_fre-100,'CutoffFrequency2',filt_fre+100, ...
%          'SampleRate',48000);
% dataIn = rx_sig2(1:L);
% dataOut = filter(bpFilt,dataIn);
% Y = fft(dataOut(1:L));
% % Y = fft(test_sig(1:L));
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = fs*(0:(L/2))/L;
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of FMCW Received Signal')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
