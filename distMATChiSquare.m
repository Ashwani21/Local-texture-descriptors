%  distMATChiSquare computes the dissimilarity between training samples and a test sample
%  DV = distMATChiSquare(train, test) returns the distance vector between training samples and a test sample. 
%  The input "train" is a n*d matrix, and each row of it represent one
%  training sample. The "test" is a 1*d vector.   

%  Examples
%  --------
%       I1=imread('rice1.png');
%       I2=imread('rice2.png');
%       I3=imread('rice3.png');
%       mapping=getmapping(8,'u2'); 
%       M(1,:)=LBPV(I1,1,8,mapping); % LBPV histogram in (8,1) neighborhood using uniform patterns
%       M(2,:)=LBPV(I2,1,8,mapping); 
%       S=LBPV(I3,1,8,mapping); 
%       DV = distMATChiSquare(M,S);

function DV = distMATChiSquare(trains, test)
% Version 1.0
% Authors: Zhenhua Guo, Lei Zhang and David Zhang
% Copyright @ Biometrics Research Centre, the Hong Kong Polytechnic University

[train_row, ~] = size(trains);

testExtend = repmat(test, train_row, 1);
subMatrix = trains-testExtend;
subMatrix2 = abs(subMatrix);
addMatrix = trains+testExtend+1;
DistMat = subMatrix2./addMatrix;
DV = sum(DistMat,2);