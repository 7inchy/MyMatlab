%%
clear;
%%
k = 500;                                 %����{ak}�Ĵ�С 
a = rand(1,k)>0.5;
ak = 2*a-1;                             %ת��1��-1������

Ts = 5e-6;                                 %��Ԫ���
fc = 20e6;                                %�ز�Ƶ��
fs = 100e6;                               %����Ƶ��
n = int32(fs*Ts);                         %ÿ�����Ų�����
%% ������λ����
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

I2 = I1.*cos(t*pi/2/Ts);  %I·��������
Q2 = Q1.*sin(t*pi/2/Ts);  %Q·��������
%% ����MSK�����ź�
ak1 = kron(ak,ones(1,n));           %�����������
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

