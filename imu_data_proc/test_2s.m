data1 = imu_loaddata('static_5m_10.txt');
% for i = 1 : data1.vec_len
%     acc(i) = sqrt(data1.x_acc(i) * data1.x_acc(i) + data1.y_acc(i) * data1.y_acc(i) + data1.z_acc(i) * data1.z_acc(i));
% end
acc_z = data1.z_acc + 9.80665 .* ones(data1.vec_len, 1);
acc = sqrt(data1.x_acc .* data1.x_acc + data1.y_acc .* data1.y_acc + acc_z .* acc_z);
acc_5s = acc(1 : 500);
plot(acc_5s);
set(gca, 'xTick', [0 : 100 : 500]);
set(gca, 'xTickLabel', {'0', '1', '2', '3', '4', '5'});
xlabel('s');
ylabel('m/s^2');
title('||a+g||');