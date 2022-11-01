% 函数功能：从.mat文件中导入imu数据后格式化打印数据
% 
% 变量：
% ------
% 输入变量：
% datafile = .mat文件名
%
% 输出变量：打印生成与输入变量同名的.txt文件
function []=imu_print_datainfo(struct)
% if length(data_file)<3 || ~strcmp(data_file(end-3:end),'.mat')
%     error('文件类型错误，请检查输入变量。');
% end
%          
% if ~exist(data_'file')
%     error('没有发现 %s 文件，请检查输入变量。',data_file);
% end

%通过检查，开始载入数据
fprintf("%s\n", "开始导入imu数据");
% fprintf("%s%s\n","数据文件：", data_file);
%从文件中加载数据
% load(data_file);
% filesplit=strsplit(data_'.');
% filename=char(filesplit(1));
% filename=[filename,'_datainfo.txt'];
filename = 'datainfo2.txt';
file=fopen(filename,'wt');



%打印数据基本信息
fprintf("采样步长：%.2f\n",struct.step_time);
fprintf("数据数量：%d\n",struct.vec_len);
fprintf("数据统计结果：\n");

%将统计数据整合成向量的形式
x_acc_table=[struct.x_acc_ave,struct.x_acc_max,struct.x_acc_min,struct.x_acc_var];
y_acc_table=[struct.y_acc_ave,struct.y_acc_max,struct.y_acc_min,struct.y_acc_var];
z_acc_table=[struct.z_acc_ave,struct.z_acc_max,struct.z_acc_min,struct.z_acc_var];

x_gyro_table=[struct.x_gyro_ave,struct.x_gyro_max,struct.x_gyro_min,struct.x_gyro_var];
y_gyro_table=[struct.y_gyro_ave,struct.y_gyro_max,struct.y_gyro_min,struct.y_gyro_var];
z_gyro_table=[struct.z_gyro_ave,struct.z_gyro_max,struct.z_gyro_min,struct.z_gyro_var];

pitch_table=[struct.pitch_ave,struct.pitch_max,struct.pitch_min,struct.pitch_var];
roll_table=[struct.roll_ave,struct.roll_max,struct.roll_min,struct.roll_var];
yaw_table=[struct.yaw_ave,struct.yaw_max,struct.yaw_min,struct.yaw_var];

%数据汇总
all_data=[x_acc_table;y_acc_table;z_acc_table;x_gyro_table;y_gyro_table;z_gyro_table;pitch_table;roll_table;yaw_table];
name_table=["加速度";"加速度";"加速度";"角速度";"角速度";"角速度";"角度";"角度";"角度";];
char_table=["X";"Y";"Z";"X";"Y";"Z";"绕X";"绕Y";"绕Z";];
unit_table=["m/s^2";"m/s^2";"m/s^2";"°/s";"°/s";"°/s";"°";"°";"°"];
print_line();
fprintf("|%-8s|%-8s|%-7s|%-7s|%-7s|%-7s|\n", "项目","单位","平均值","最大值","最小值","均方差");
print_line();
for row=1:3
    %print_line(file);
    fprintf("|");
    %fprintf("%s",char_table(row));
    fprintf("%-7s",char_table(row)+name_table(row));
    fprintf("|");
    fprintf("%-10s",unit_table(row));
    for col=3:6
        fprintf("|");
        fprintf("%-10.4f",all_data(row,col-2));
    end
    fprintf("|\n");
    print_line();
end

for row=4:9
    %print_line(file);
    fprintf("|");
    %fprintf("%s",char_table(row));
    fprintf("%-7s",char_table(row)+name_table(row));
    fprintf("|");
    fprintf("%-9s",unit_table(row));
    for col=3:6
        fprintf("|");
        fprintf("%-10.4f",all_data(row,col-2)); 
    end
    fprintf("|\n");
    print_line();
end
% print_line(file);
% fclose(file);
end

% 函数功能：在指定txt文件中打印分隔线
% 
% 变量：
% ------
% 输入变量：
% file = .txt文件名
function []=print_line()
for i =1:6
    fprintf('*');
    for j =1:10
       fprintf('-'); 
    end
end
fprintf("*\n");
end