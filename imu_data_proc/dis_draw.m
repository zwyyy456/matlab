% 函数功能：
% 
% 变量：
% ------
% 输入变量：
% data_file = .mat文件名
% draw_mask = 绘图选择数据掩码，具体掩码规则如下；
% 
% 对应掩码规则：
% 用一个十六进制数表示；格式为0x0000到0x8777；
% 
% bit0 = x速度掩码；
% bit1 = y速度掩码；
% bit2 = z速度掩码；
% bit3 无实际意义，可用于扩展使用；
% bit4 = x位移掩码；
% bit5 = y位移掩码；
% bit6 = z位移掩码；
% bit7 无实际意义，可用于扩展使用；
% bit8 无实际意义，可用于扩展使用；
% bit9 无实际意义，可用于扩展使用；
% bit10 无实际意义，可用于扩展使用；
% bit11 无实际意义，可用于扩展使用；
% bit12 无实际意义，可用于扩展使用；
% bit13 无实际意义，可用于扩展使用；
% bit14 无实际意义，可用于扩展使用；
% bit15 该位为0表示相同轴数据放在同一张图中绘制，为1表示所有相同量纲数据放在同一张图中绘制；
% z轴  |  y轴  |  x轴
% 0    |   0   |   0   --->0
% 0    |   0   |   1   --->1
% 0    |   1   |   0   --->2
% 0    |   1   |   1   --->3
% 1    |   0   |   0   --->4
% 1    |   0   |   1   --->5
% 1    |   1   |   0   --->6
% 1    |   1   |   1   --->7


function [] = dis_draw(draw_mask, res)
    [mode, mask_mat] = mask2mat(draw_mask);
    
    % 将所有数据以矩阵形式表示，方便灵活使用
    all_data = [res.x_vel, res.y_vel, res.z_vel, res.x_dis, res.y_dis, res.z_dis, res.pitch, res.roll, res.yaw];
    fprintf("载入数据成功，开始绘制相应图线。\n");
    ylabel_vec = ['m/s'; 'm';"°"];
    str_vec = ['X';'Y';'Z'];
    val_vec = ["速度";"位移";"角度"];
    pic_num=[sum(mask_mat,1)',sum(mask_mat,2)];
    
    figure_cnt=1;
    for figure_num=1:3
        if pic_num(figure_num,mode+1)
            %如果有需要画的图线
            figure(figure_cnt);
            figure_cnt=figure_cnt+1;
            sub_cnt=1;
            for i = 1:3
                if (mode&&mask_mat(figure_num,i)) || (~mode&&mask_mat(i,figure_num))
                        subplot(pic_num(figure_num,mode+1),1,sub_cnt);
                        sub_cnt=sub_cnt+1;
                        if mode
                            x=figure_num;
                            y=i;
                        else
                            y=figure_num;
                            x=i;
                        end
                        %绘制图线并标好单位
                        plot(all_data(:,(x-1)*3+y));
                        set(gca, 'xTick', [0: 6000:  res.vec_len]);
                        set(gca,'xTickLabel',{'0','1','2','3','4','5'});
                        xlabel('min'); ylabel(ylabel_vec(x));title(str_vec(y)+"轴"+val_vec(x)+"随时间变化的曲线") ;                
                end
            end
        end
    end
end

% 函数功能：将三个数据的掩码转化为矩阵的形式，每一行表示为该数据的掩码二进制表示
% 
% 变量：
% ------
% 输入变量：
% mask = 十六进制掩码数
%
% 输出变量：
% mask_mat = 输出的掩码二进制矩阵，三行分别表示加速度、角速度、角度对应的二进制掩码。
function [mode,mask_mat]=mask2mat(mask)
    mask_bin = dec2bin(mask, 16);
    % 将第9位到12位置零
    for i = 5 : 8
        mask_bin(i) = '0';
    end
    %将掩码补到16位
    while length(mask_bin)<16
        mask_bin=['0',mask_bin];
    end
    %将最高位转为mode
    mode=str2double(mask_bin(1));
    mask_mat=zeros(3,3); 
    %依次转换每行掩码
    for row = 1:3
        row_bin= mask_bin(17-4*row:20-4*row);
        for col = 1:3
            mask_mat(row,col) = str2double(row_bin(5-col));
        end
    end
end
