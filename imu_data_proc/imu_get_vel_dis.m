% 函数功能：计算速度与位移，将数据变化以图线方式表现出来
% 
% 变量：
% ------
% 输入变量：
% is_rm_ave = 控制是否去掉平均值的参数，为0表示不去掉，其他表示去掉
% dis_flag = 控制是否计算位移的参数，为0表示不计算，为1表示计算
% m_filter = 使用的滤波类型，为1表示平均值滤波，为2表示中值滤波，为3表示高斯滤波，
% 其他值表示不滤波
% 
% 输出变量：
% x_vel = x轴速度
% y_vel = y轴速度
% z_vel = z轴速度
% x_dis = x轴位移
% y_dis = y轴位移
% z_dis = z轴位移


function [res] = imu_get_vel_dis(struct)
    res = struct;
    v_x = 0;
    v_y = 0;
    v_z = 0;

    d_x = 0;
    d_y = 0;
    d_z = 0;

    res.x_vel = [0];
    res.y_vel = [0];
    res.z_vel = [0];

    res.x_dis = [0];
    res.y_dis = [0];
    res.z_dis = [0];

% if (is_rm_ave ~= 0)
%     x_acc = x_acc - x_acc_ave .* ones(vec_len, 1);
%     y_acc = y_acc - y_acc_ave .* ones(vec_len, 1);
%     z_acc = z_acc - z_acc_ave .* ones(vec_len, 1);
% end
% 

    for i = 1 : struct.vec_len - 1
    %     v_x = v_x + x_acc(i) / 200 + x_acc(i + 1) / 200;
        v_x = v_x + struct.x_acc(i) / 200 + struct.x_acc(i + 1) / 200;
        v_y = v_y + struct.y_acc(i) / 200 + struct.y_acc(i + 1) / 200;
        v_z = v_z + struct.z_acc(i) / 200 + struct.z_acc(i + 1) / 200;
        res.x_vel = [res.x_vel; v_x];
        res.y_vel = [res.y_vel; v_y];
        res.z_vel = [res.z_vel; v_z];

        d_x = d_x + res.x_vel(i) / 200 + res.x_vel(i) / 200;
        res.x_dis = [res.x_dis; d_x];
        d_y = d_y + res.y_vel(i) / 200 + res.y_vel(i) / 200;
        res.y_dis = [res.y_dis; d_y];
        d_z = d_z + res.z_vel(i) / 200 + res.z_vel(i) / 200;
        res.z_dis = [res.z_dis;d_z];
    end
        
        
   
end


