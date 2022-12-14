% 函数功能：对imu_loaddata导入的数据进行处理
%
% 变量:
% ------
% 输入变量：
% struct = imu_loaddata输出的结构体变量
% is_rm_ave = 是否去掉平均值, 为0表示不去掉
% filter_type = 滤波器类型，为1表示平均值滤波，为2表示中值滤波，为3表示高斯滤波，其他表示不进行时域滤波
% 
function [raw_struct, mod_struct] = imu_process_data(struct, is_rm_ave, filter_type)
    raw_struct = struct;
    mod_struct = struct;
    if (is_rm_ave ~= 0)
        mod_struct.x_acc = struct.x_acc - struct.x_acc_ave .* ones(struct.vec_len, 1);
        mod_struct.y_acc = struct.y_acc - struct.y_acc_ave .* ones(struct.vec_len, 1);
        mod_struct.z_acc = struct.z_acc - struct.z_acc_ave .* ones(struct.vec_len, 1);
    end
    
    if (filter_type == 1)
        mod_struct.x_acc = movmean(struct.x_acc, 10);
        mod_struct.y_acc = movmean(struct.y_acc, 10);
        mod_struct.z_acc = movmean(struct.z_acc, 10);
    elseif (filter_type == 2)
        mod_struct.x_acc = movmedian(struct.x_acc, 10);
        mod_struct.y_acc = movmedian(struct.y_acc, 10);
        mod_struct.z_acc = movmedian(struct.z_acc, 10);
    elseif (filter_type == 3)
        mod_struct.x_acc = smoothdata(struct.x_acc, 'gaussian', 20);
        mod_struct.y_acc = smoothdata(struct.y_acc, 'gaussian', 20);
        mod_struct.z_acc = smoothdata(struct.z_acc, 'gaussian', 20);
    end
            
end

