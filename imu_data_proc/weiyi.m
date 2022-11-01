v_x=0;
v_y=0;
v_z=0;

vx_cum=[];
vy_cum=[];
vz_cum=[];

x_cum=[];
y_cum=[];
z_cum=[];

v_x_mod=0;
v_x_mod_tmp = 0;
v_y_mod=0;
v_z_mod=0;

vx_cum_mod=[];
vy_cum_mod=[];
vz_cum_mod=[];

x_cum_mod=[];
y_cum_mod=[];
z_cum_mod=[];

x=0;
y=0;
z=0;
x_mod = 0;
y_mod = 0;
z_mod = 0;

for i =1:size(acce_x)
    v_x=v_x+acce_x(i,1)*1/720;
    x=x+v_x*1/720;
    vx_cum=[vx_cum ,v_x];
    x_cum=[x_cum,x];
    
%     v_y=v_y+acce_y(i,1)*1/100;
%     y=y+v_y*1/100;
%     vy_cum=[vy_cum ,v_y];
%     y_cum=[y_cum,y];
%     
%     v_z=v_z+acce_z(i,1)*1/100;
%     z=z+v_z*1/100;
%     vz_cum=[vz_cum ,v_z];
%     z_cum=[z_cum,z];
end

for i =1:size(acce_x_mod) - 1
    if (acce_x_mod > 0.1)
        acce_x_mod  = 0.1;
    elseif (acce_x_mod < -0.1)
        acce_x_mod = -0.1;
    end
    v_x_mod_tmp = v_x_mod;
    v_x_mod=v_x_mod+acce_x_mod(i,1)*1/720 + acce_x_mod(i + 1, 1) / 720;
    x_mod=x_mod + v_x_mod / 720 + v_x_mod_tmp / 720;
    vx_cum_mod=[vx_cum_mod ,v_x_mod];
    x_cum_mod=[x_cum_mod,x_mod];
    
%     v_y_mod=v_y_mod+acce_y_mod(i,1)*1/100;
%     y_mod=y_mod+v_y_mod*1/100;
%     vy_cum_mod=[vy_cum_mod ,v_y_mod];
%     y_cum_mod=[y_cum_mod,y_mod];
%     
%     v_z_mod=v_z_mod+acce_z_mod(i,1)*1/100;
%     z_mod=z_mod+v_z_mod*1/100;
%     vz_cum_mod=[vz_cum_mod ,v_z_mod];
%     z_cum_mod=[z_cum_mod,z_mod];
end



