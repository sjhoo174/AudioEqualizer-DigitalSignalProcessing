function b= assignment1_sinc_corr(ntaps,Fs)

npts = 2000
Fs = 48000

fpts = 0:1/npts:1
x = pi*fpts'/2
mval = sin(x)./x
b = fir2(512, fpts, mval')


% [h w] = freqz(b, 1)
% plot(w/pi*Fs/2, abs(h))
