function Normalized_EVM = evm_full(I,x)
% x should be odd
factor = [0 0 6  0 50  0 196 0 540 0 1210 0 2366  0 4200  0  6936 0  10830 0  16170  0  23276 0    32500];

a = 1:x;
k_xcentroid = repmat(a,[x,1]);
k_ycentroid = k_xcentroid';
U = ones(x,x);
k_cov = k_xcentroid .* k_ycentroid;
k_xvar = k_xcentroid.^2;
k_yvar = k_ycentroid.^2;
conv2_UI = conv2(I,U,'same');
X_centroid = conv2(I,k_xcentroid,'same')./conv2_UI;
Y_centroid = conv2(I,k_ycentroid,'same')./conv2_UI;

X_centroid(~isfinite(X_centroid))=0;
Y_centroid(~isfinite(Y_centroid))=0;

X_var = conv2(I,k_xvar,'same')-(X_centroid).^2 .* conv2_UI;
Y_var = conv2(I,k_yvar,'same')-(Y_centroid).^2 .* conv2_UI;
Cov_xy = conv2(I,k_cov,'same')- X_centroid .* Y_centroid .* conv2_UI;

cum_var = X_var+Y_var;
bw_sqrt = sqrt(cum_var.^2-4*(X_var.*Y_var-Cov_xy.^2));
EVM = (cum_var+bw_sqrt)/2;

Normalized_EVM = EVM./(I*factor(x));
