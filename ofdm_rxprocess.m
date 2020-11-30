
% raw_signal = [1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;1;-1];
rx_sig = read_complex_binary('C:\Users\Bobo\Desktop\new\ofdm_static_rx.dat',10e6);
rx_sig = downsample(rx_sig(1:6000000),5);

raw_signal = [zeros(52,1);1;-1;1;-1;1;-1;1;-1;1;-1;1;-1];
sig = ifft(raw_signal,64);
% real_sig = real(sig); %只能发送实部信号
cyclic_suffix = sig(1:20); %插入循环后缀
tx_sig = [sig;cyclic_suffix;zeros(200,1)];

for i = 1:50
    
    figure;
    [r1,lags1] = xcorr(tx_sig2,rx_sig(1000001+(i-1)*284:1000284+(i-1)*284));
    plot(-lags1,real(r1));
end

% hold on;
% [r2,lags2] = xcorr(real_sig,rx_data(20285:20568));
% plot(-lags2,real(r2));
% 
% [r3,lags3] = xcorr(real_sig,rx_data(20569:20852));
% plot(-lags3,real(r3));
% legend('第一帧','第二帧','第三帧');