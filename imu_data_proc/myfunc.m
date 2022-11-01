% 函数功能：从txt文件中导入imu数据
% 
% 变量：
% ------
% 输入变量：
% datafile = imu数据文件,格式参见数据文件格式说明
% 
% 输出变量：
% step_time = 采样步长（单位秒）
% x_acc = x轴加速度（向量，单位m/s^2）
% x_acc_ave = x轴加速度平均值
% x_acc_max = x轴加速度最大值
% x_acc_min = x轴加速度最小值
% x_acc_var = x轴加速度方差
% y_acc = y轴加速度（向量，单位m/s^2）
% y_acc_ave = y轴加速度平均值
% y_acc_max = y轴加速度最大值
% y_acc_min = y轴加速度最小值
% y_acc_var = y轴加速度方差

function imu_loaddata(datafile);


% 函数功能：打印imu数据信息
function imu_print_datainfo();

% 打印采样步长、向量长度、加速度平均值、最大值、最小值、方差、角度

% 函数功能：绘制imu数据图
% 
% 变量：
% ------
% 输入变量：
% 
function imu_draw(acc_mask, gyro_mask, angle_mask);
