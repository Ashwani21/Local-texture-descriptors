function [hist_LBP_u2,hist_LBP_u2_convex_up,hist_LBP_u2_convex_down] = LBP_func(image,window_size,thres)
[row,col]=size(image);
evm = evm_full(image,window_size);
evm = evm(2:end-1,2:end-1);
%% Append all 8-neighborhood to a single matrix
neigh_mtx=zeros(row-2,col-2,8);
cent_mtx=image(2:end-1,2:end-1);
neigh_mtx(:,:,1)=image(1:row-2,1:col-2);
neigh_mtx(:,:,2)=image(1:row-2,2:col-1);
neigh_mtx(:,:,3)=image(1:row-2,3:col);
neigh_mtx(:,:,4)=image(2:row-1,3:col);
neigh_mtx(:,:,5)=image(3:row,3:col);
neigh_mtx(:,:,6)=image(3:row,2:col-1);
neigh_mtx(:,:,7)=image(3:row,1:col-2);
neigh_mtx(:,:,8)=image(2:row-1,1:col-2);
%% Calculate LBP code
cent_mtx_rep=repmat(cent_mtx,[1,1,8]);
mapping=getmapping(8,'u2');
LBP=neigh_mtx>=cent_mtx_rep;
LBP_code=zeros(row-2,col-2);
for neighbor=1:8
    LBP_code=LBP_code+2^(neighbor-1)*LBP(:,:,neighbor);
end
LBP_u2=mapping.table(LBP_code+1);
hist_LBP_u2=hist(LBP_u2(:),0:58);
hist_LBP_u2_convex_up=hist(LBP_u2(evm>=thres),0:58);
hist_LBP_u2_convex_down=hist(LBP_u2(evm<thres),0:58);
end