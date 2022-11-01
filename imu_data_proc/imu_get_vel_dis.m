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


function [x_vel, y_vel, z_vel, x_dis, y_dis, z_dis] = imu_get_vel_dis(is_rm_ave, dis_flag, m_filter)
vec_len = evalin('base', 'vec_len');
x_acc = evalin('base', 'x_acc');
x_acc_ave = evalin('base', 'x_acc_ave');
y_acc = evalin('base', 'y_acc');
y_acc_ave = evalin('base', 'y_acc_ave');
z_acc = evalin('base', 'z_acc');
z_acc_ave = evalin('base', 'z_acc_ave');

v_x = 0;
v_y = 0;
v_z = 0;

d_x = 0;
d_y = 0;
d_z = 0;

x_vel = [0];
y_vel = [0];
z_vel = [0];

x_dis = [0];
y_dis = [0];
z_dis = [0];

if (is_rm_ave ~= 0)
    x_acc = x_acc - x_acc_ave .* ones(vec_len, 1);
    y_acc = y_acc - y_acc_ave .* ones(vec_len, 1);
    z_acc = z_acc - z_acc_ave .* ones(vec_len, 1);
end

if (m_filter == 1)
    x_acc = movmean(x_acc, 10);
    y_acc = movmean(y_acc, 10);
    z_acc = movmean(z_acc, 10);
elseif (m_filter == 2)
    x_acc = movmedian(x_acc, 10);
    y_acc = movmedian(y_acc, 10);
    z_acc = movmedian(z_acc, 10);
elseif (m_filter == 3)
    x_acc = smoothdata(x_acc, 'gaussian', 20);
    y_acc = smoothdata(y_acc, 'gaussian', 20);
    z_acc = smoothdata(z_acc, 'gaussian', 20);
end
for i = 1 : vec_len - 1
%     v_x = v_x + x_acc(i) / 200 + x_acc(i + 1) / 200;
    v_x = v_x + x_acc(i) / 100;
    v_y = v_y + y_acc(i) / 200 + y_acc(i + 1) / 200;
    v_z = v_z + z_acc(i) / 200 + z_acc(i + 1) / 200;
    x_vel = [x_vel; v_x];
    y_vel = [y_vel; v_y];
    z_vel = [z_vel; v_z];
    if (dis_flag ~= 0)
        d_x = d_x + x_vel(i) / 200 + x_vel(i) / 200;
        x_dis = [x_dis, d_x];
        d_y = d_y + y_vel(i) / 200 + y_vel(i) / 200;
        y_dis = [y_dis, d_y];
        d_z = d_z + z_vel(i) / 200 + z_vel(i) / 200;
        z_dis = [z_dis, d_z];
    end
end
% plot(x_vel);
% hold;
plot(x_dis);
        
        
    

end

