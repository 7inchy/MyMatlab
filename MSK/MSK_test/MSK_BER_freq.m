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
title('MSK 频差与误码率的关系图(相差为0)');
xlabel('频差/Hz');
ylabel('BER');
    