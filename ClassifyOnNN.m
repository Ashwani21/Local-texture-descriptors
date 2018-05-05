%  ClassifyOnNN computes the classification accuracy
%  CP=ClassifyOnNN(DM,trainClassIDs,testClassIDs) returns the classification accuracy
%  The input "DM" is a m*n distance matrix, m is the number of test samples, n is the number of training samples
%  'trainClassIDs' and 'testClassIDs' stores the class ID of training and
%  test samples

%  Examples
%  --------
%       I1=imread('rice1.png');
%       I2=imread('rice2.png');
%       I3=imread('rice3.png');
%       I4=imread('rice4.png');
%       mapping=getmapping(8,'u2');
%       M(1,:)=LBPV(I1,1,8,mapping); % LBPV histogram in (8,1) neighborhood using uniform patterns
%       M(2,:)=LBPV(I2,1,8,mapping);
%       S(1,:)=LBPV(I3,1,8,mapping);
%       S(2,:)=LBPV(I4,1,8,mapping);
%       M = ConvertU2LBP(M,8); % convert u2 LBP or LBPV to meet the requirement of global matching scheme
%       S = ConvertU2LBP(S,8);
%       DM = distGMPDRN(M,S,8,2,3);
%       CP=ClassifyOnNN(DM,[1,1],[1,1]);

function CP=ClassifyOnNN(DM,top_n,Images_per_class)
% Version 1.0
% Authors: Zhenhua Guo, Lei Zhang and David Zhang
% Copyright @ Biometrics Research Centre, the Hong Kong Polytechnic University
[row,~]=size(DM);
rightCount = 0;
DM_sorted=sort(DM,2);
for j=1:row
    class=ceil(j/Images_per_class);
    Max_dist=DM_sorted(j,top_n);
    Retrieved_objects_same_category=(DM(j,:)<=Max_dist);
    Matched=sum(Retrieved_objects_same_category((class-1)*Images_per_class+1:class*Images_per_class));
    rightCount = rightCount+Matched;
end
CP = rightCount/(row*top_n);