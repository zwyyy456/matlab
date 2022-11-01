function [res] = weiyi(struct)
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

%     if (is_rm_ave ~= 0)
        struct.x_acc = struct.x_acc - struct.x_acc_ave .* ones(struct.vec_len, 1);
        struct.y_acc = struct.y_acc - struct.y_acc_ave .* ones(struct.vec_len, 1);
        struct.z_acc = struct.z_acc - struct.z_acc_ave .* ones(struct.vec_len, 1);
%     end


    for i = 1 : struct.vec_len - 1
        v_x = v_x + struct.x_acc(i) / 200 + struct.x_acc(i + 1) / 200;
        v_y = v_y + struct.y_acc(i) / 200 + struct.y_acc(i + 1) / 200;
        v_z = v_z + struct.z_acc(i) / 200 + struct.z_acc(i + 1) / 200;
        res.x_vel = [res.x_vel; v_x];
        res.y_vel = [res.y_vel; v_y];
        res.z_vel = [res.z_vel; v_z];

        d_x = d_x + res.x_vel(i) / 200 + res.x_vel(i) / 200;
        res.x_dis = [res.x_dis, d_x];
        d_y = d_y + res.y_vel(i) / 200 + res.y_vel(i) / 200;
        res.y_dis = [res.y_dis, d_y];
        d_z = d_z + res.z_vel(i) / 200 + res.z_vel(i) / 200;
        res.z_dis = [res.z_dis, d_z];
    end
    
    figure(1);
    subplot(3, 1, 1);
    plot(res.x_vel);
    set(gca, 'xTick', [0 : 6000 : struct.vec_len]);
    set(gca, 'xTickLabel', {'0', '1', '2', '3', '4', '5'});
    ylabel('m/s');
    title('x轴速度随时间变化的曲线');

    
    subplot(3, 1, 2);
    plot(res.y_vel);
    set(gca, 'xTick', [0 : 6000 : struct.vec_len]);
    set(gca, 'xTickLabel', {'0', '1', '2', '3', '4', '5'});
    ylabel('m/s');
    title('y轴速度随时间变化的曲线');

    
    subplot(3, 1, 3);
    plot(res.z_vel);
    set(gca, 'xTick', [0 : 6000 : struct.vec_len]);
    set(gca, 'xTickLabel', {'0', '1', '2', '3', '4', '5'});
    ylabel('m/s');
    title('z轴速度随时间变化的曲线');

    
    figure(2);
    
    subplot(3, 1, 1);
    plot(res.x_dis);
    set(gca, 'xTick', [0 : 6000 : struct.vec_len]);
    set(gca, 'xTickLabel', {'0', '1', '2', '3', '4', '5'});
    xlabel('min');
    ylabel('m');
    title('x轴位移随时间变化的曲线');

    
    subplot(3, 1, 2);
    plot(res.y_dis);
    set(gca, 'xTick', [0 : 6000 : struct.vec_len]);
    set(gca, 'xTickLabel', {'0', '1', '2', '3', '4', '5'});
    xlabel('min');
    ylabel('m/s');
    title('y轴位移随时间变化的曲线');

    
    subplot(3, 1, 3);
    plot(res.z_dis);
    set(gca, 'xTick', [0 : 6000 : struct.vec_len]);
    set(gca, 'xTickLabel', {'0', '1', '2', '3', '4', '5'});
    xlabel('min');
    ylabel('m/s');
    title('z轴位移随时间变化的曲线');

        
   
end



