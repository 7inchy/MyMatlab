
%%
% I3 = S_MSK.*cos(2*pi*fc*t);
% Q3 = S_MSK.*sin(2*pi*fc*t);
% H_MSK = demod_filter;
% I3_demod = filter(H_MSK,I3);
% Q3_demod = filter(H_MSK,Q3);

% figure
% subplot(2,2,1)
% plot(I3_demod);
% subplot(2,2,2);
% plot(I2);
% subplot(2,2,3);
% plot(Q3_demod);
% subplot(2,2,4);
% plot(Q2);
%% 相干解调

% %接收端载频
% fc_ = 20e6;
% %接收端载波相位
% c_ = 0;

I3 = S_MSK.*cos(2*pi*fc_*t+c_);
Q3 = S_MSK.*sin(2*pi*fc_*t+c_);
H_MSK = demod_filter;
I3_filtered = filter(H_MSK,I3);
Q3_filtered = filter(H_MSK,Q3);

% [I3freqDomain,I3frequencyRange] = centeredFFT(I3,fs);
% [I3_filteredfreqDomain,I3_filteredfrequencyRange] = centeredFFT(I3_filtered,fs);
% figure
% stem(I3frequencyRange,abs(I3freqDomain));
% figure
% stem(I3_filteredfrequencyRange,abs(I3_filteredfreqDomain));
% figure
% subplot(2,2,1)
% plot(I3_filtered);
% subplot(2,2,2);
% plot(I2);
% subplot(2,2,3);
% plot(Q3_filtered);
% subplot(2,2,4);
% plot(Q2);


t_ = 1/fs;                 % 延时t'

I3_demod = zeros(1,k);
Q3_demod = zeros(1,k);
I3_demod_delay = zeros(1,k);
Q3_demod_delay = zeros(1,k);
I3_demod(1:k) = I3_filtered(n/2:n:end);
Q3_demod(1:k) = Q3_filtered(n/2:n:end);
I3_demod_delay(1:k) = I3_filtered((n/2+t_*fs):n:end);
Q3_demod_delay(1:k) = Q3_filtered((n/2+t_*fs):n:end);

Y = I3_demod.*Q3_demod_delay-Q3_demod.*I3_demod_delay;
% figure
% plot(Y)
ak_demod = zeros(1,k);
for i=1:k
    if Y(i)<0
        ak_demod(i) = 1;
    else
        if Y(i)>0
            ak_demod(i) = -1;
        end
    end
end

%% 计算误比特率
right = 0;
for i=1:k
    if ak(i) == ak_demod(i)
        right = right+1;
    end
end
ber = 1-right/k;
        

   
