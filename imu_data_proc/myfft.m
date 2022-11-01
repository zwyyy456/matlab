function [] = myfft(struct)
sf = 100; % sample freq
fmin = 10;
fmax = 50;
c = 1;
it = 2; % 积分次数

n = struct.vec_len
t = 0 : 1 / sf : (n - 1) / sf; % create time variable
nfft = 2 ^ nextpow2(n);
% x_acc = struct.x_acc - struct.x_acc_ave .* ones(struct.vec_len, 1);
y_x_acc = abs(fft(struct.x_acc));
% y_acc = struct.y_acc - struct.y_acc_ave .* ones(struct.vec_len, 1);
y_y_acc = abs(fft(struct.y_acc));
% z_acc = struct.z_acc - struct.z_acc_ave .* ones(struct.vec_len, 1);
y_z_acc = abs(fft(struct.z_acc));


x = (0 : n - 1) * sf / n;

    subplot(3, 1, 1);
    plot(y_x_acc, x);
    title('x轴加速度频谱图');

    
    subplot(3, 1, 2);
    plot(y_y_acc, x);
    title('y轴加速度频谱图');

    
    subplot(3, 1, 3);
    plot(y_z_acc, x);
    title('z轴加速度频谱图');



end

