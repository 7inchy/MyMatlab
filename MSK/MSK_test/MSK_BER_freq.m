BER = [];
num = 50;
Fc_ = fc-1/3/Ts:2/3/num/Ts:fc+1/3/Ts-2/3/num/Ts;
c_ = 0;
for ii = 1:num
    fc_ = Fc_(ii);
    run('MSK_demodulation.m');
    BER(ii) = ber;
end
figure
plot(Fc_-fc,BER);
title('MSK Ƶ���������ʵĹ�ϵͼ(���Ϊ0)');
xlabel('Ƶ��/Hz');
ylabel('BER');
    