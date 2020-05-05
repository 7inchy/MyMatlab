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
title('MSK 相差与误码率的关系图(频差为0)');
xlabel('相差');
ylabel('BER');
set(gca,'XTick',0:pi/2:2*pi);