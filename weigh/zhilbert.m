weight_data = csvread('480sps_200g_2.csv');
weight_data = weight_data(500 : 3000);
t_data_raw = 0 : 1 / 480 : 3000 / 480;
t_data = t_data_raw(500 : 3000)';
plot(weight_data);
hold on;
[y_up, y_low] = envelope(weight_data, 100, 'peak');
plot(y_up);

cftool;
% F = @(c, t_data)c(1) + c(1) * exp(-c(2) * t_data) / c(3);
% c0 = [200, 1, 0.08];
% [c, resnorm] = lsqcurvefit(F, c0, t_data, y_up);
% cftool;

