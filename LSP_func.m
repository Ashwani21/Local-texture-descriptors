function [hist_LSP_u2_convex_up,hist_LSP_u2_convex_down] = LSP_func(image,window_size,thres)
%Local Skew Pattern
% Split histogram into two bucket if (local neighborhood mean) > (local neighborhood median)
[row,col]=size(image);
evm = evm_full(image,window_size);
evm = evm(3:end-2,3:end-2);
%% Append all 8-neighborhood to a single matrix

%% Calculate LSP code
% Calculate neighbor mean and median
neigh_mean = conv2(image,ones(5,5),'same')/25;
neigh_median = ordfilt2(image,12,ones(5,5));

LSP = neigh_mean >= neigh_median;

neigh_mtx=zeros(row-4,col-4,8);
neigh_mtx(:,:,1)=LSP(3:row-2,3:col-2);
neigh_mtx(:,:,2)=LSP(3:row-2,4:col-1);
neigh_mtx(:,:,3)=LSP(3:row-2,5:col);
neigh_mtx(:,:,4)=LSP(4:row-1,5:col);
neigh_mtx(:,:,5)=LSP(5:row,5:col);
neigh_mtx(:,:,6)=LSP(5:row,4:col-1);
neigh_mtx(:,:,7)=LSP(5:row,3:col-2);
neigh_mtx(:,:,8)=LSP(4:row-1,3:col-2);

%% Calculate LBP code
mapping=getmapping(8,'u2');

LSP_code=zeros(row-4,col-4);
for neighbor=1:8
    LSP_code=LSP_code+2^(neighbor-1)*neigh_mtx(:,:,neighbor);
end
LSP_u2=mapping.table(LSP_code+1);
hist_LSP_u2_convex_up=hist(LSP_u2(evm>=thres),0:58);
hist_LSP_u2_convex_down=hist(LSP_u2(evm<thres),0:58);

end