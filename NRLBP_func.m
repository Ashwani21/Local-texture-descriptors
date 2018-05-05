function [hist_NRLBP_u2,hist_NRLBP_u2_convex_up,hist_NRLBP_u2_convex_down] = NRLBP_func(image,window_size,thres)
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
%% Calculate NRLBP code
cent_mtx_rep=repmat(cent_mtx,[1,1,8]);
NRLBP=neigh_mtx>=cent_mtx_rep;
NRLBP_uncertain=abs(neigh_mtx-cent_mtx_rep)<2; % Threshold of 2 is used, as mentioned in the paper.
NRLBP_code=zeros(row-2,col-2);
NRLBP_code_uncertainity_bit=zeros(row-2,col-2);
for neighbor=1:8
    NRLBP_code=NRLBP_code+2^(neighbor-1)*NRLBP(:,:,neighbor);
    NRLBP_code_uncertainity_bit=NRLBP_code_uncertainity_bit+2^(neighbor-1)*NRLBP_uncertain(:,:,neighbor);
end

load('nrlbp_mapping_info_1d.mat')

hist_NRLBP_u2_convex_up = zeros(1,58);
hist_NRLBP_u2_convex_down = zeros(1,58);
convex_up = evm>=thres ;
convex_down = evm<thres ;

for hist_bin = 1:58 % Ignoring non-uniform pattern 
    sum_bin_convex_up = 0;
    sum_bin_convex_down = 0;
    for plane = 1:17 % Taking patterns with weight > (1/17);
        temp_convex_down = (nrlbp_mapping_1d(NRLBP_code+1+NRLBP_code_uncertainity_bit*256+(plane-1)*256*256) == hist_bin).*nrlbp_mapping_weight_1d(NRLBP_code+1+NRLBP_code_uncertainity_bit*256).*convex_down;
        sum_bin_convex_down = sum_bin_convex_down + sum(temp_convex_down(:));
        
        temp_convex_up = (nrlbp_mapping_1d(NRLBP_code+1+NRLBP_code_uncertainity_bit*256+(plane-1)*256*256) == hist_bin).*nrlbp_mapping_weight_1d(NRLBP_code+1+NRLBP_code_uncertainity_bit*256).*convex_up;
        sum_bin_convex_up = sum_bin_convex_up + sum(temp_convex_up(:));
    end
    hist_NRLBP_u2_convex_up(hist_bin) = sum_bin_convex_up;
    hist_NRLBP_u2_convex_down(hist_bin) = sum_bin_convex_down;
end
hist_NRLBP_u2 = hist_NRLBP_u2_convex_up + hist_NRLBP_u2_convex_down;
end