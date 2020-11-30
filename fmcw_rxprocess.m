
rx_sig = read_complex_binary('C:\Users\Bobo\Desktop\new\fmcw_static_rx.dat',10e6);

bandwidth = 6000;
f0 = 22000;
fs = 200000;
time = 0.05;
t = 1/fs:1/fs:0.05;

fmcw_sig = reshape(cos(2*pi*(f0+bandwidth/(2*time)*t).*t)+1i*sin(2*pi*(f0+bandwidth/(2*time)*t).*t),10000,1);
ref_sig = reshape(cos(2*pi*f0*(-t)+2*pi*bandwidth/(2*time)*(-t.^2))+1i*sin(2*pi*f0*(-t)+2*pi*bandwidth/(2*time)*(-t.^2)),10000,1);
% [r1,lags1] = xcorr(fmcw_sig,rx_sig(6000000:6010000));
% plot(-lags1,imag(r1));
i = 1;
R1 = rx_sig(1000001+(i-1)*10000:1000000+i*10000).*ref_sig;
L = 10000;
Y = fft(R1);
% Y = fft(test_sig(1:L));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
[PKS,LOCS]= findpeaks(P1,'MinPeakHeight',0.1);

f = fs*(0:(L/2))/L;
figure;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of FMCW Received Signal')
xlabel('f (Hz)')
ylabel('|P1(f)|')
