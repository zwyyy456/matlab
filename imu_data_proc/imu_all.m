struct = imu_loaddata('static_5m_9.txt');
[raw_struct, struct] = imu_process_data(struct, 1, 0);
res = imu_get_vel_dis(struct);
dis_draw(0x8777, res);