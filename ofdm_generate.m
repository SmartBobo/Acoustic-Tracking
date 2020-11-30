
clc;
clear;
close all;

%从20k-25k,预设采样率为50k
raw_signal = [zeros(52,1);1;-1;1;-1;1;-1;1;-1;1;-1;1;-1];
sig = ifft(raw_signal,64);

cyclic_suffix = sig(1:20); %插入循环后缀
tx_sig = [sig;cyclic_suffix;zeros(200,1)]; %插入两百个静默samples
tx_sig2 = [];
for i = 1:4000
    tx_sig2 = [tx_sig2;tx_sig];
end      
%插值到200k
tx_sig2 = interp(tx_sig2,4); 
write_complex_binary(tx_sig2,'ofdm.dat');
% audiowrite('ofdm噪声版.wav',tx_sig2,48000);
