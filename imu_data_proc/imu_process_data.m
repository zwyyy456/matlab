% 函数功能：对imu_loaddata导入的数据进行处理
%
% 变量:
% ------
% 输入变量：
% data_file = imu_loaddata导入的数据
% is_rm_ave = 是否去掉平均值, 为0表示不去掉低频
% freq_low = 最小截止频率，为0表示不过滤低频
% freq_max = 最大截止频率，不高于采样频率的一半，为0表示不过滤高频
function [] = imu_process_data(data_file, is_rm_ave, freq_low, freq_high)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    load(data_file);
    if (is_rm_ave != 0)
        x_acc = x_acc - x_acc_ave .* ones(vec_len, 1);
        y_acc = y_acc - y_acc_ave .* ones(vec_len, 1);
        z_acc = z_acc - z_acc_ave .* ones(vec_len, 1);
        
        x_gyro = x_gyro - x_gyro_ave .* ones(vec_len, 1);
        y_gyro = y_gyro - y_gyro_ave .* ones(vec_len, 1);
        z_gyro = z_gyro - z_gyro_ave .* ones(vec_len, 1);
        
        pitch = pitch - pitch_ave .* ones(vec_len, 1);
        roll = roll - roll_ave .* ones(vec_len, 1);
        yaw = yaw - yaw_ave .* ones(vec_len, 1);
    end
    
    if (freq_low >= 0 & freq_high >= 0 & freq_low < freq_high & freq_high * 2 < freq)
        if (freq_high == 0)
            
        
    
    
end

