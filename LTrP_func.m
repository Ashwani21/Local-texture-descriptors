function [hist_LTrP_u2,hist_LTrP_u2_convex_up,hist_LTrP_u2_convex_down] = LTrP_func(image,window_size,thres)
[row,col]=size(image);
evm = evm_full(image,window_size);
evm = evm(2:end-2,2:end-2);

temp = conv2(image,[1 -1]);
diff_x_0 = temp(:,2:end)>0;
temp = -1*conv2(image,[-1 1]);
diff_x_180 = temp(:,1:end-1)>0;

temp = -1*conv2(image,[-1 ;1]);
diff_y_270 = temp(2:end,:)>0;
temp = -1*conv2(image,[1 ;-1]);
diff_y_90 = temp(1:end-1,:)>0;

pat_x_0_y_90 = diff_x_0 + 2*diff_y_90;
pat_x_0_y_270 = diff_x_0 + 2*diff_y_270;
pat_x_180_y_90 = diff_x_180 + 2*diff_y_90;
pat_x_180_y_270 = diff_x_180 + 2*diff_y_270;

%% Calculate LTrP Pattern for 0 degree and 90 degree direction (derivative along Postive x axis and Positive y axis)
% Append all 8-neighborhood to a single matrix

pat_i_y = pat_x_0_y_90;
neigh_mtx=zeros(row-3,col-3,8);
neigh_mtx(:,:,1)=pat_i_y(2:row-2,2:col-2);
neigh_mtx(:,:,2)=pat_i_y(2:row-2,3:col-1);
neigh_mtx(:,:,3)=pat_i_y(2:row-2,4:col);
neigh_mtx(:,:,4)=pat_i_y(3:row-1,4:col);
neigh_mtx(:,:,5)=pat_i_y(4:row,4:col);
neigh_mtx(:,:,6)=pat_i_y(4:row,3:col-1);
neigh_mtx(:,:,7)=pat_i_y(4:row,2:col-2);
neigh_mtx(:,:,8)=pat_i_y(3:row-1,2:col-2);

mapping=getmapping(8,'u2');

neigh_mtx_temp = neigh_mtx == 1;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_0_90_1=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_0_90_1_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_0_90_1_convex_up=hist(LTrP_u2(evm<thres),0:58);

neigh_mtx_temp = neigh_mtx == 2;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_0_90_2=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_0_90_2_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_0_90_2_convex_up=hist(LTrP_u2(evm<thres),0:58);

neigh_mtx_temp = neigh_mtx == 3;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_0_90_3=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_0_90_3_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_0_90_3_convex_up=hist(LTrP_u2(evm<thres),0:58);

%% Calculate LTrP Pattern for 0 degree and 270 degree direction (derivative along Postive x axis and Negative y axis)
% Append all 8-neighborhood to a single matrix

pat_i_y = pat_x_0_y_270;
neigh_mtx=zeros(row-3,col-3,8);
neigh_mtx(:,:,1)=pat_i_y(2:row-2,2:col-2);
neigh_mtx(:,:,2)=pat_i_y(2:row-2,3:col-1);
neigh_mtx(:,:,3)=pat_i_y(2:row-2,4:col);
neigh_mtx(:,:,4)=pat_i_y(3:row-1,4:col);
neigh_mtx(:,:,5)=pat_i_y(4:row,4:col);
neigh_mtx(:,:,6)=pat_i_y(4:row,3:col-1);
neigh_mtx(:,:,7)=pat_i_y(4:row,2:col-2);
neigh_mtx(:,:,8)=pat_i_y(3:row-1,2:col-2);

mapping=getmapping(8,'u2');

neigh_mtx_temp = neigh_mtx == 1;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_0_270_1=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_0_270_1_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_0_270_1_convex_up=hist(LTrP_u2(evm<thres),0:58);

neigh_mtx_temp = neigh_mtx == 2;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_0_270_2=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_0_270_2_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_0_270_2_convex_up=hist(LTrP_u2(evm<thres),0:58);

neigh_mtx_temp = neigh_mtx == 3;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_0_270_3=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_0_270_3_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_0_270_3_convex_up=hist(LTrP_u2(evm<thres),0:58);

%% Calculate LTrP Pattern for 180 degree and 90 degree direction (derivative along Negative x axis and Positive y axis)
% Append all 8-neighborhood to a single matrix

pat_i_y = pat_x_180_y_90;
neigh_mtx=zeros(row-3,col-3,8);
neigh_mtx(:,:,1)=pat_i_y(2:row-2,2:col-2);
neigh_mtx(:,:,2)=pat_i_y(2:row-2,3:col-1);
neigh_mtx(:,:,3)=pat_i_y(2:row-2,4:col);
neigh_mtx(:,:,4)=pat_i_y(3:row-1,4:col);
neigh_mtx(:,:,5)=pat_i_y(4:row,4:col);
neigh_mtx(:,:,6)=pat_i_y(4:row,3:col-1);
neigh_mtx(:,:,7)=pat_i_y(4:row,2:col-2);
neigh_mtx(:,:,8)=pat_i_y(3:row-1,2:col-2);

mapping=getmapping(8,'u2');

neigh_mtx_temp = neigh_mtx == 1;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_180_90_1=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_180_90_1_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_180_90_1_convex_up=hist(LTrP_u2(evm<thres),0:58);

neigh_mtx_temp = neigh_mtx == 2;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_180_90_2=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_180_90_2_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_180_90_2_convex_up=hist(LTrP_u2(evm<thres),0:58);

neigh_mtx_temp = neigh_mtx == 3;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_180_90_3=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_180_90_3_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_180_90_3_convex_up=hist(LTrP_u2(evm<thres),0:58);

%% Calculate LTrP Pattern for 180 degree and 270 degree direction (derivative along Negative x axis and Negative y axis)
% Append all 8-neighborhood to a single matrix

pat_i_y = pat_x_180_y_270;
neigh_mtx=zeros(row-3,col-3,8);
neigh_mtx(:,:,1)=pat_i_y(2:row-2,2:col-2);
neigh_mtx(:,:,2)=pat_i_y(2:row-2,3:col-1);
neigh_mtx(:,:,3)=pat_i_y(2:row-2,4:col);
neigh_mtx(:,:,4)=pat_i_y(3:row-1,4:col);
neigh_mtx(:,:,5)=pat_i_y(4:row,4:col);
neigh_mtx(:,:,6)=pat_i_y(4:row,3:col-1);
neigh_mtx(:,:,7)=pat_i_y(4:row,2:col-2);
neigh_mtx(:,:,8)=pat_i_y(3:row-1,2:col-2);

mapping=getmapping(8,'u2');

neigh_mtx_temp = neigh_mtx == 1;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_180_270_1=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_180_270_1_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_180_270_1_convex_up=hist(LTrP_u2(evm<thres),0:58);

neigh_mtx_temp = neigh_mtx == 2;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_180_270_2=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_180_270_2_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_180_270_2_convex_up=hist(LTrP_u2(evm<thres),0:58);

neigh_mtx_temp = neigh_mtx == 3;
LTrP_code_i_y=zeros(row-3,col-3);
for neighbor=1:8
    LTrP_code_i_y=LTrP_code_i_y+2^(neighbor-1)*neigh_mtx_temp(:,:,neighbor);
end
LTrP_u2=mapping.table(LTrP_code_i_y+1);
hist_LTrP_u2_180_270_3=hist(LTrP_u2(:),0:58);
hist_LTrP_u2_180_270_3_convex_down=hist(LTrP_u2(evm>=thres),0:58);
hist_LTrP_u2_180_270_3_convex_up=hist(LTrP_u2(evm<thres),0:58);

hist_LTrP_u2 = [hist_LTrP_u2_0_90_1 hist_LTrP_u2_0_90_2 hist_LTrP_u2_0_90_3 hist_LTrP_u2_180_270_1 hist_LTrP_u2_180_270_2 hist_LTrP_u2_180_270_3 hist_LTrP_u2_180_90_1 hist_LTrP_u2_180_90_2 hist_LTrP_u2_180_90_3 hist_LTrP_u2_0_270_1 hist_LTrP_u2_0_270_2 hist_LTrP_u2_0_270_3];

hist_LTrP_u2_convex_down = [hist_LTrP_u2_0_90_1_convex_down hist_LTrP_u2_0_90_2_convex_down hist_LTrP_u2_0_90_3_convex_down hist_LTrP_u2_180_270_1_convex_down hist_LTrP_u2_180_270_2_convex_down hist_LTrP_u2_180_270_3_convex_down hist_LTrP_u2_180_90_1_convex_down hist_LTrP_u2_180_90_2_convex_down hist_LTrP_u2_180_90_3_convex_down hist_LTrP_u2_0_270_1_convex_down hist_LTrP_u2_0_270_2_convex_down hist_LTrP_u2_0_270_3_convex_down];
hist_LTrP_u2_convex_up = [hist_LTrP_u2_0_90_1_convex_up hist_LTrP_u2_0_90_2_convex_up hist_LTrP_u2_0_90_3_convex_up hist_LTrP_u2_180_270_1_convex_up hist_LTrP_u2_180_270_2_convex_up hist_LTrP_u2_180_270_3_convex_up hist_LTrP_u2_180_90_1_convex_up hist_LTrP_u2_180_90_2_convex_up hist_LTrP_u2_180_90_3_convex_up hist_LTrP_u2_0_270_1_convex_up hist_LTrP_u2_0_270_2_convex_up hist_LTrP_u2_0_270_3_convex_up];

end