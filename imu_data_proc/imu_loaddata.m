% 函数功能：从txt文件中导入imu数据，并将输出变量存储成为与txt文件同名的.mat文件
% 
% 变量：
% ------
% 输入变量：
% datafile = imu数据文件,格式参见数据文件格式说明
% 
% 输出变量：
% 结构体struct，其成员变量如下：
% step_time = 采样步长（单位秒）
% vec_len = 向量数据长度
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

% z_acc = y轴加速度（向量，单位m/s^2）
% z_acc_ave = y轴加速度平均值
% z_acc_max = y轴加速度最大值
% z_acc_min = y轴加速度最小值
% z_acc_var = y轴加速度方差

% x_gyro = x轴角速度（向量，单位°/s）
% x_gyro_ave = x轴角速度平均值
% x_gyro_max = x轴角速度最大值
% x_acc_min = x轴角速度最小值
% x_acc_var = x轴角速度方差

% y_gyro = y轴角速度（向量，单位°/s）
% y_gyro_ave = y轴角速度平均值
% y_gyro_max = y轴角速度最大值
% y_acc_min = y轴角速度最小值
% y_acc_var = y轴角速度方差

% z_gyro = z轴角速度（向量，单位°/s）
% z_gyro_ave = z轴角速度平均值
% z_gyro_max = z轴角速度最大值
% z_acc_min = z轴角速度最小值
% z_acc_var = z轴角速度方差

% pitch = 俯仰角（向量，单位°）
% pitch_ave = 俯仰角平均值
% pitch_max = 俯仰角最大值
% pitch_min = 俯仰角最小值
% pitch_var = 俯仰角方差

% roll = 横滚角（向量，单位°）
% roll_ave = 横滚角平均值
% roll_max = 横滚角最大值
% roll_min = 横滚角最小值
% roll_var = 横滚角方差

% yaw = 航向角（向量，单位°）
% yaw_ave = 航向角平均值
% yaw_max = 航向角最大值
% yaw_min = 航向角最小值
% yaw_var = 航向角方差
function [struct]=imu_loaddata(datafile)
     %对文件类型、是否存在文件的检查
     if length(datafile)<3 || ~strcmp(datafile(end-3:end),'.txt')
         error('文件类型错误，请检查输入变量。');
     end
         
     if ~exist(datafile,'file')
         error('没有发现 %s 文件，请检查输入变量。',datafile);
     end
     
     %通过检查，开始载入数据
     fprintf("%s\n", "开始导入imu数据");
     fprintf("%s%s\n","数据文件：", datafile);
     %读取文件名为datafile的文件中的数据并转换成struct类型数据，包括textdata和data两个结构体
     txt_struct=importdata(datafile);
     data_raw=txt_struct.data;
     text_raw=txt_struct.textdata;
     %逐行检查文件元信息，找到freq参数（缺省为100）
     freq=100;
     find_freq=0;
     
     for i = 1 : length(text_raw)
         cell_now=strsplit(char(text_raw(i)),'=');
         text=char(cell_now(1));
         if strcmp(text,'freq')
            freq=str2double(char(cell_now(2)));
            if freq<0 || freq>10000
                 error('频率参数超出范围，请检查。');
            end
            find_freq=1;
            break
         end
     end
    
     if ~find_freq
        fprintf("未找到freq参数，缺省为100。\n");
     end
     struct.step_time=1/freq;
        
     struct.vec_len=length(data_raw);
     %检查数据完整性
     if data_raw(end,1)>struct.vec_len
         fprintf("共丢失 %d 条数据，分别是：\n",data_raw(end,1)-struct.vec_len);
         %进行插值操作
         if data_raw(1,1)~=1
             temp=data_raw(1,:);
             temp(1)=1;
            data_raw=[temp;data_raw];
            fprintf("%d\n",1);
         end
         for i =1:struct.vec_len
            if data_raw(i,1)~=i
                fprintf("%d\n",i);
                data_raw=[data_raw(1:i-1,:);(data_raw(i-1,:)+data_raw(i,:))./2.0;data_raw(i:end,:)];
            end
         end
         fprintf("插值成功。共有 %d 条数据\n",data_raw(end,1));
     end
     %更新插值后的数组长度
     struct.vec_len=length(data_raw);
     %解析data数据，直接得到三轴加速度、角速度、角度
     struct.pitch = data_raw(:,2);
     struct.roll = data_raw(:,3);
     struct.yaw = data_raw(:,4);
     %加速度满量程为16384，单位是重力加速度g(9.81m/s^2)，需要转换
     %z轴方向包括其本生的重力加速度g，需要去除
     G=9.80665;
     factor=16384/G;   
     struct.x_acc=data_raw(:,5)./factor;
     struct.y_acc=data_raw(:,6)./factor;
     struct.z_acc=data_raw(:,7)./factor-G.*ones(struct.vec_len,1);
     %角速度的满量程为16.4，需要转换
     GYRO_RANGE=16.4;
     struct.x_gyro=data_raw(:,8)./GYRO_RANGE;
     struct.y_gyro=data_raw(:,9)./GYRO_RANGE;
     struct.z_gyro=data_raw(:,10)./GYRO_RANGE;
     %分别计算三轴加速度、角速度、欧拉角数据对应的平均值、最大值、最小值、方差
     struct.x_acc_ave=mean(struct.x_acc);
     struct.y_acc_ave=mean(struct.y_acc);
     struct.z_acc_ave=mean(struct.z_acc);
 
     struct.x_acc_max=max(struct.x_acc);
     struct.y_acc_max=max(struct.y_acc);
     struct.z_acc_max=max(struct.z_acc);
 
     struct.x_acc_min=min(struct.x_acc);
     struct.y_acc_min=min(struct.y_acc);
     struct.z_acc_min=min(struct.z_acc);
 
     struct.x_acc_var=var(struct.x_acc);
     struct.y_acc_var=var(struct.y_acc);
     struct.z_acc_var=var(struct.z_acc);

     struct.x_gyro_ave=mean(struct.x_gyro);
     struct.y_gyro_ave=mean(struct.y_gyro);
     struct.z_gyro_ave=mean(struct.z_gyro);

     struct.x_gyro_max=max(struct.x_gyro);
     struct.y_gyro_max=max(struct.y_gyro);
     struct.z_gyro_max=max(struct.z_gyro);

     struct.x_gyro_min=min(struct.x_gyro);
     struct.y_gyro_min=min(struct.y_gyro);
     struct.z_gyro_min=min(struct.z_gyro);

     struct.x_gyro_var=var(struct.x_gyro);
     struct.y_gyro_var=var(struct.y_gyro);
     struct.z_gyro_var=var(struct.z_gyro);

     struct.pitch_ave=mean(struct.pitch);
     struct.roll_ave=mean(struct.roll);
     struct.yaw_ave=mean(struct.yaw);

     struct.pitch_max=max(struct.pitch);
     struct.roll_max=max(struct.roll);
     struct.yaw_max=max(struct.yaw);

     struct.pitch_min=min(struct.pitch);
     struct.roll_min=min(struct.roll);
     struct.yaw_min=min(struct.yaw);

     struct.pitch_var=var(struct.pitch);
     struct.roll_var=var(struct.roll);
     struct.yaw_var=var(struct.yaw);
     fprintf("导入数据成功。\n");
end
