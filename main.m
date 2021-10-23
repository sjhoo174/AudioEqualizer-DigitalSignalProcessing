f(1) = 40;
f(2) = 80;
f(3) = 155;
f(4) = 310;
f(5) = 625;
f(6) = 1250;
f(7) = 2500;
f(8) = 5000;
f(9) = 10000;
f(10) = 20000;

v(1) = 10^(input('Gain for band 1 in dB =')/20);
v(2) = 10^(input('Gain for band 2 in dB =')/20);
v(3) = 10^(input('Gain for band 3 in dB =')/20);
v(4) = 10^(input('Gain for band 4 in dB =')/20);
v(5) = 10^(input('Gain for band 5 in dB =')/20);
v(6) = 10^(input('Gain for band 6 in dB =')/20);
v(7) = 10^(input('Gain for band 7 in dB =')/20);
v(8) = 10^(input('Gain for band 8 in dB =')/20);
v(9) = 10^(input('Gain for band 9 in dB =')/20);
v(10) = 10^(input('Gain for band 10 in dB =')/20);
g_amp= 10^(input('Gain for preamp in dB =')/20); 

[y Fs] = audioread('vln-lin-cs.wav');

y = y(:,1);

v = v*g_amp;
b = equalizer(y, Fs, v, f);


v = 20*log10(abs(v));
f1 = figure;
figure(f1);
plot([0 f(1) f(1) f(2) f(2) f(3) f(3) f(4) f(4) f(5) f(5) f(6) f(6) f(7) ...
    f(7) f(8) f(8) f(9) f(9) f(10) f(10) Fs], [v(1) v(1) v(2) v(2) v(3) v(3)...
    v(4) v(4) v(5) v(5) v(6) v(6) v(7) v(7) v(8) v(8) v(9) v(9) v(10) v(10) 1 1]);
title('Ideal Frequency Gain Response');
xlabel('Frequency/Hz');
ylabel('Magnitude (dB)');
axis([0 20000 -9 15]);

[h w] = freqz(b, 1);


f2 = figure;
figure(f2);
plot(w/pi*Fs/2, 20*log10(abs(h)));
title('Frequency Gain Response');
xlabel('Frequency/Hz');
ylabel('Magnitude (dB)');
axis([0 20000 -9 15]);


f3 = figure;
figure(f3);
plot(w/pi*Fs/2, unwrap(angle(h)));
title('Phase Response');
xlabel('Frequency/Hz');
ylabel('Phase/rad');

f4 = figure;
figure(f4);
impz(b, 1,512);
title('Impulse Response');

x = (1:1:length(y))/Fs;
f5 = figure;
figure(f5);
plot(x, y);
title('Input y in Time');
xlabel('Time/Seconds');
ylabel('Magnitude');

S = fft(y, 512);
w = (0:255)/512*Fs;
S = S(1:256);
f6 = figure;
figure(f6);
plot(w, abs(S));
size(S);
title('Input y in Frequency (512 bins)');
xlabel('Frequency/Hz');
ylabel('Magnitude');

sf = filter(b, 1, y);

SF = fft(sf, 512);
w = (0:255)/512*Fs;
SF = SF(1:256);
f8 = figure;
figure(f8);
plot(w, abs(SF));
title('Filtered y in Frequency (512 bins)');
xlabel('Frequency/Hz');
ylabel('Magnitude');

x = (1:1:length(sf))/Fs;
f5 = figure;
figure(f5);
plot(x, sf);
title('Filtered Signal in Time');
xlabel('Time/Seconds');
ylabel('Magnitude');

sf_norm = sf/max(abs(sf)) ;
x = (1:1:length(sf_norm))/Fs;
f5 = figure;
figure(f5);
plot(x, sf_norm);
title('Normalized Filtered Signal in Time');
xlabel('Time/Seconds');
ylabel('Magnitude');

SF_norm = fft(sf_norm, 512);
w = (0:255)/512*Fs;
SF_norm = SF_norm(1:256);
f6 = figure;
figure(f6);
plot(w, abs(SF_norm));
size(SF_norm);
title('Normalized Filtered Signal in Frequency (512 bins)');
xlabel('Frequency/Hz');
ylabel('Magnitude');

player = audioplayer(y, Fs);
playblocking(player);

player = audioplayer(sf, Fs);
playblocking(player);

player = audioplayer(sf_norm, Fs);
playblocking(player);

