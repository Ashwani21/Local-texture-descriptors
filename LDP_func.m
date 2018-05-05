function [hist_LDP_u2,hist_LDP_u2_convex_up,hist_LDP_u2_convex_down] = LDP_func(image,window_size,thres)
[row,col]=size(image);
evm = evm_full(image,window_size);
evm = evm(2:end-1,2:end-1);

dir_0 = conv2(image,[-1 1],'same');
dir_45 = conv2(image,[0 1;-1 0],'same');
dir_90 = conv2(image,[1 ; -1],'same');
dir_135 = conv2(image,[-1 0;0 1],'same');

%% Calculate LDP Pattern for 0 degree direction
% Append all 8-neighborhood to a single matrix

LDP_i = dir_0;
neigh_mtx=zeros(row-2,col-2,8);
cent_mtx=LDP_i(2:end-1,2:end-1);
neigh_mtx(:,:,1)=LDP_i(1:row-2,1:col-2);
neigh_mtx(:,:,2)=LDP_i(1:row-2,2:col-1);
neigh_mtx(:,:,3)=LDP_i(1:row-2,3:col);
neigh_mtx(:,:,4)=LDP_i(2:row-1,3:col);
neigh_mtx(:,:,5)=LDP_i(3:row,3:col);
neigh_mtx(:,:,6)=LDP_i(3:row,2:col-1);
neigh_mtx(:,:,7)=LDP_i(3:row,1:col-2);
neigh_mtx(:,:,8)=LDP_i(2:row-1,1:col-2);
cent_mtx_rep=repmat(cent_mtx,[1,1,8]);
mapping=getmapping(8,'u2');
LDP_temp=neigh_mtx>=cent_mtx_rep;
LDP_code_i=zeros(row-2,col-2);
for neighbor=1:8
    LDP_code_i=LDP_code_i+2^(neighbor-1)*LDP_temp(:,:,neighbor);
end
LDP_u2_i=mapping.table(LDP_code_i+1);

hist_LDP_u2_0=hist(LDP_u2_i(:),0:58);
hist_LDP_u2_convex_up_0=hist(LDP_u2_i(evm>=thres),0:58);
hist_LDP_u2_convex_down_0=hist(LDP_u2_i(evm<thres),0:58);

%% Calculate LDP Pattern for 45 degree direction
% Append all 8-neighborhood to a single matrix

LDP_i = dir_45;
neigh_mtx=zeros(row-2,col-2,8);
cent_mtx=LDP_i(2:end-1,2:end-1);
neigh_mtx(:,:,1)=LDP_i(1:row-2,1:col-2);
neigh_mtx(:,:,2)=LDP_i(1:row-2,2:col-1);
neigh_mtx(:,:,3)=LDP_i(1:row-2,3:col);
neigh_mtx(:,:,4)=LDP_i(2:row-1,3:col);
neigh_mtx(:,:,5)=LDP_i(3:row,3:col);
neigh_mtx(:,:,6)=LDP_i(3:row,2:col-1);
neigh_mtx(:,:,7)=LDP_i(3:row,1:col-2);
neigh_mtx(:,:,8)=LDP_i(2:row-1,1:col-2);

cent_mtx_rep=repmat(cent_mtx,[1,1,8]);
LDP_temp=neigh_mtx>=cent_mtx_rep;
LDP_code_i=zeros(row-2,col-2);
for neighbor=1:8
    LDP_code_i=LDP_code_i+2^(neighbor-1)*LDP_temp(:,:,neighbor);
end
LDP_u2_i=mapping.table(LDP_code_i+1);

hist_LDP_u2_45=hist(LDP_u2_i(:),0:58);
hist_LDP_u2_convex_up_45=hist(LDP_u2_i(evm>=thres),0:58);
hist_LDP_u2_convex_down_45=hist(LDP_u2_i(evm<thres),0:58);

%% Calculate LDP Pattern for 90 degree direction
% Append all 8-neighborhood to a single matrix

LDP_i = dir_90;
neigh_mtx=zeros(row-2,col-2,8);
cent_mtx=LDP_i(2:end-1,2:end-1);
neigh_mtx(:,:,1)=LDP_i(1:row-2,1:col-2);
neigh_mtx(:,:,2)=LDP_i(1:row-2,2:col-1);
neigh_mtx(:,:,3)=LDP_i(1:row-2,3:col);
neigh_mtx(:,:,4)=LDP_i(2:row-1,3:col);
neigh_mtx(:,:,5)=LDP_i(3:row,3:col);
neigh_mtx(:,:,6)=LDP_i(3:row,2:col-1);
neigh_mtx(:,:,7)=LDP_i(3:row,1:col-2);
neigh_mtx(:,:,8)=LDP_i(2:row-1,1:col-2);

cent_mtx_rep=repmat(cent_mtx,[1,1,8]);
LDP_temp=neigh_mtx>=cent_mtx_rep;
LDP_code_i=zeros(row-2,col-2);
for neighbor=1:8
    LDP_code_i=LDP_code_i+2^(neighbor-1)*LDP_temp(:,:,neighbor);
end
LDP_u2_i=mapping.table(LDP_code_i+1);

hist_LDP_u2_90=hist(LDP_u2_i(:),0:58);
hist_LDP_u2_convex_up_90=hist(LDP_u2_i(evm>=thres),0:58);
hist_LDP_u2_convex_down_90=hist(LDP_u2_i(evm<thres),0:58);

%% Calculate LDP Pattern for 135 degree direction
% Append all 8-neighborhood to a single matrix

LDP_i = dir_135;
neigh_mtx=zeros(row-2,col-2,8);
cent_mtx=LDP_i(2:end-1,2:end-1);
neigh_mtx(:,:,1)=LDP_i(1:row-2,1:col-2);
neigh_mtx(:,:,2)=LDP_i(1:row-2,2:col-1);
neigh_mtx(:,:,3)=LDP_i(1:row-2,3:col);
neigh_mtx(:,:,4)=LDP_i(2:row-1,3:col);
neigh_mtx(:,:,5)=LDP_i(3:row,3:col);
neigh_mtx(:,:,6)=LDP_i(3:row,2:col-1);
neigh_mtx(:,:,7)=LDP_i(3:row,1:col-2);
neigh_mtx(:,:,8)=LDP_i(2:row-1,1:col-2);

cent_mtx_rep=repmat(cent_mtx,[1,1,8]);
LDP_temp=neigh_mtx>=cent_mtx_rep;
LDP_code_i=zeros(row-2,col-2);
for neighbor=1:8
    LDP_code_i=LDP_code_i+2^(neighbor-1)*LDP_temp(:,:,neighbor);
end
LDP_u2_i=mapping.table(LDP_code_i+1);

hist_LDP_u2_135=hist(LDP_u2_i(:),0:58);
hist_LDP_u2_convex_up_135=hist(LDP_u2_i(evm>=thres),0:58);
hist_LDP_u2_convex_down_135=hist(LDP_u2_i(evm<thres),0:58);

% Concatenate LDP patterns
hist_LDP_u2=[hist_LDP_u2_0 hist_LDP_u2_45 hist_LDP_u2_90 hist_LDP_u2_135];
hist_LDP_u2_convex_up=[hist_LDP_u2_convex_up_0 hist_LDP_u2_convex_up_45 hist_LDP_u2_convex_up_90 hist_LDP_u2_convex_up_135];
hist_LDP_u2_convex_down=[hist_LDP_u2_convex_down_0 hist_LDP_u2_convex_down_45 hist_LDP_u2_convex_down_90 hist_LDP_u2_convex_down_135];
end