%%
clear;
%%
k = 500;                                 %序列{ak}的大小 
a = rand(1,k)>0.5;
ak = 2*a-1;                             %转成1，-1的序列

Ts = 5e-6;                                 %码元宽度
fc = 20e6;                                %载波频率
fs = 100e6;                               %采样频率
n = int32(fs*Ts);                         %每个符号采样数
%% 计算相位常数
c = zeros(1,k);
c(1) = 0;
for i = 2:k
    if ak(i) == ak(i-1)
        c(i) = c(i-1);
    else 
        c(i) = c(i-1) + (ak(i-1)-ak(i))*(i-1)*pi/2;
%         c(i) = c(i-1) + (ak(i-1)-ak(i))*i*pi/2; 
    end
end
c_mod_2pi = mod(c,2*pi);

%%
I = cos(c_mod_2pi);                     %Ik
Q = ak.*cos(c_mod_2pi);                 %-Qk
I1 = kron(I,ones(1,n));
Q1 = kron(Q,ones(1,n));

t = [1/fs : 1/fs : k*Ts];

I2 = I1.*cos(t*pi/2/Ts);  %I路成型数据
Q2 = Q1.*sin(t*pi/2/Ts);  %Q路成型数据
%% 生成MSK调制信号
ak1 = kron(ak,ones(1,n));           %采样后的序列
S_MSK = I2.* cos(2*pi*fc*t) - Q2.*sin(2*pi*fc*t);

% [YfreqDomain,frequencyRange] = centeredFFT(S_MSK,fs);
% figure
% stem(frequencyRange,abs(YfreqDomain));
%%
% figure
% plot(S_MSK);
% 
figure
subplot(3,1,1);
stairs(ak1);
set(gca,'XTick',1:n:k*n);
axis([1 k*n -1.5 1.5]);
subplot(3,1,2);
plot(I2);
set(gca,'XTick',1:n:k*n);
axis([1 k*n -1 1]);
subplot(3,1,3);
plot(Q2);
set(gca,'XTick',1:n:k*n);
axis([1 k*n -1 1]);

