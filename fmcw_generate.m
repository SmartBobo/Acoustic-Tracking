clc;
clear;


bandwidth = 6000;
f0 = 22000;
fs = 200000;
time = 0.05;
t = 1/fs:1/fs:0.05;

fmcw_sig = reshape(cos(2*pi*(f0+bandwidth/(2*time)*t).*t)+1i*sin(2*pi*(f0+bandwidth/(2*time)*t).*t),10000,1);

tx_sig = [];
for i = 1:400
    tx_sig = [tx_sig;fmcw_sig];
end
write_complex_binary(tx_sig,'fmcw.dat');


% audiowrite('fmcw.wav',tx_sig,48000);

