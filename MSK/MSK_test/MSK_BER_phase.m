BER = [];
num = 50;
fc_ = fc;
C_ = 2*pi/num:2*pi/num:2*pi;
for ii = 1:num
    c_ = C_(ii);
    run('MSK_demodulation.m');
    BER(ii) = ber;
end
figure
plot(C_,BER);
title('MSK ����������ʵĹ�ϵͼ(Ƶ��Ϊ0)');
xlabel('���');
ylabel('BER');
set(gca,'XTick',0:pi/2:2*pi);