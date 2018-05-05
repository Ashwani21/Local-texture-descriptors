clear all;
clc

% classification accuracy: NRLBP (original) is 67.450
% classification accuracy: NRLBP (With histogram refinement) is 72.190

database = 'Corel';
Performance_measure='Recall';
% function DemoCodesCorel
% This demo codes shows the basic operations of WLBP

base_root= [pwd '/'];

% picture number of the database

% Radius and Neighborhood
R=1;
P=8;
if strcmp(database,'Corel') ;
    rootpic = strcat(base_root,'image.orig');
    picNum = 1000;
    Images_per_class=100;
end

if strcmp(database,'GHIM') ;
    rootpic = strcat(base_root,'GHIM-10K');
    picNum = 10000;
    Images_per_class=500;
end

if strcmp(database,'Brodatz') ;
    rootpic = strcat(base_root,'Brodatz');
    picNum = 112;
    Images_per_class=16;
end

LSP_convex_up=zeros(picNum,59);
LSP_convex_down=zeros(picNum,59);

LBP=zeros(picNum,59);
LBP_convex_up=zeros(picNum,59);
LBP_convex_down=zeros(picNum,59);

NRLBP=zeros(picNum,58);
NRLBP_convex_up=zeros(picNum,58);
NRLBP_convex_down=zeros(picNum,58);

LDP=zeros(picNum,59*4);
LDP_convex_up=zeros(picNum,59*4);
LDP_convex_down=zeros(picNum,59*4);

LTrP=zeros(picNum,59*12);
LTrP_convex_up=zeros(picNum,59*12);
LTrP_convex_down=zeros(picNum,59*12);

Local_texture_queue = {'LBP', 'LDP', 'LTrP', 'NRLBP'};
% genearte CLBP features
for image_idx=1:picNum
    
    if image_idx > 1
        fprintf(' %d / %d',image_idx,picNum);
    end
    
    if strcmp(database,'Corel') ;
        filename = sprintf('%s//%d.jpg', rootpic, image_idx-1);
    else
        filename = sprintf('%s//%d.jpg', rootpic, image_idx);
    end
    
    Gray = imread(filename);
    if ~(strcmp(database,'Brodatz')) ;
        Gray = rgb2gray(Gray);
    end
    Gray = double(Gray);
    
    if image_idx == 1
        fprintf('\nGenerating Local Skew pattern (LSP); Percentage completed :')
    end
    %     Generate histogram of LBP
    [LSP_convex_up(image_idx,:),LSP_convex_down(image_idx,:)] = LSP_func(Gray,15,1.0045);
    
    if ((image_idx > 1) && (image_idx < picNum))
        fprintf(repmat('\b',1,length(num2str(picNum))+length(num2str(image_idx))+4));
    end
end

for Local_texture_id = 1:4
    Local_texture = Local_texture_queue{Local_texture_id};
    for image_idx=1:picNum
        
        if image_idx > 1
            fprintf(' %d / %d',image_idx,picNum);
        end
        
        if strcmp(database,'Corel') ;
            filename = sprintf('%s//%d.jpg', rootpic, image_idx-1);
        else
            filename = sprintf('%s//%d.jpg', rootpic, image_idx);
        end
        
        Gray = imread(filename);
        if ~(strcmp(database,'Brodatz')) ;
            Gray = rgb2gray(Gray);
        end
        Gray = double(Gray);
        
        switch Local_texture
            
            case 'LBP'
                if image_idx == 1
                    fprintf('\nbenchmarking Local biniary pattern (LBP); Percentage completed :')
                end
                %     Generate histogram of LBP
                [LBP(image_idx,:),LBP_convex_up(image_idx,:),LBP_convex_down(image_idx,:)] = LBP_func(Gray,15,1.0045);
                
                if  image_idx == picNum
                    trainIDs=1:picNum;
                    testIDs=1:picNum;
                    Top_n_retrieval=10;
                    
                    % classification test using LBP
                    Local_texture_feature = LBP ;
                    trains = Local_texture_feature(trainIDs,:);
                    tests = Local_texture_feature(testIDs,:);
                    trainNum = size(trains,1);
                    testNum = size(tests,1);
                    DM = zeros(testNum,trainNum);
                    for i=1:testNum;
                        test = tests(i,:);
                        DM(i,:) = distMATChiSquare(trains,test)';
                    end
                    CP=ClassifyOnNN(DM,Top_n_retrieval,Images_per_class);
                    fprintf('\nclassification accuracy: LBP (original) is %0.3f %',CP*100);
                    
                    
                    Local_texture_feature = [LBP_convex_up LBP_convex_down LSP_convex_up LSP_convex_down] ;
                    trains = Local_texture_feature(trainIDs,:);
                    tests = Local_texture_feature(testIDs,:);
                    trainNum = size(trains,1);
                    testNum = size(tests,1);
                    DM = zeros(testNum,trainNum);
                    for i=1:testNum;
                        test = tests(i,:);
                        DM(i,:) = distMATChiSquare(trains,test)';
                    end
                    CP=ClassifyOnNN(DM,Top_n_retrieval,Images_per_class);
                    fprintf('\nclassification accuracy: LBP (With histogram refinement) is %0.3f %',CP*100);
                    
                end
                
            case 'LDP'
                if image_idx == 1
                    fprintf('\nbenchmarking Local derivative pattern (LDP); Percentage completed :')
                end
                %         Generate histogram of LDP
                [LDP(image_idx,:),LDP_convex_up(image_idx,:),LDP_convex_down(image_idx,:)] = LDP_func(Gray,15,1.0045);
                
                if  image_idx == picNum
                    
                    trainIDs=1:picNum;
                    testIDs=1:picNum;
                    Top_n_retrieval=10;
                    
                    % classification test using LDP
                    Local_texture_feature = LDP ;
                    trains = Local_texture_feature(trainIDs,:);
                    tests = Local_texture_feature(testIDs,:);
                    trainNum = size(trains,1);
                    testNum = size(tests,1);
                    DM = zeros(testNum,trainNum);
                    for i=1:testNum;
                        test = tests(i,:);
                        DM(i,:) = distMATChiSquare(trains,test)';
                    end
                    CP=ClassifyOnNN(DM,Top_n_retrieval,Images_per_class);
                    fprintf('\nclassification accuracy: LDP (original) is %0.3f %',CP*100);
                    
                    
                    Local_texture_feature = [LDP_convex_up LDP_convex_down LSP_convex_up LSP_convex_down] ;
                    trains = Local_texture_feature(trainIDs,:);
                    tests = Local_texture_feature(testIDs,:);
                    trainNum = size(trains,1);
                    testNum = size(tests,1);
                    DM = zeros(testNum,trainNum);
                    for i=1:testNum;
                        test = tests(i,:);
                        DM(i,:) = distMATChiSquare(trains,test)';
                    end
                    CP=ClassifyOnNN(DM,Top_n_retrieval,Images_per_class);
                    fprintf('\nclassification accuracy: LDP (With histogram refinement) is %0.3f %',CP*100);
                    
                end
                
            case 'LTrP'
                if image_idx == 1
                    fprintf('\nbenchmarking Local Tetra pattern (LTrP); Percentage completed :')
                end
                % classification test using LTrP
                %     Generate histogram of LTrP
                [LTrP(image_idx,:),LTrP_convex_up(image_idx,:),LTrP_convex_down(image_idx,:)] = LTrP_func(Gray,15,1.0045);
                
                if  image_idx == picNum
                    trainIDs=1:picNum;
                    testIDs=1:picNum;
                    Top_n_retrieval=10;
                    
                    Local_texture_feature = LTrP ;
                    trains = Local_texture_feature(trainIDs,:);
                    tests = Local_texture_feature(testIDs,:);
                    trainNum = size(trains,1);
                    testNum = size(tests,1);
                    DM = zeros(testNum,trainNum);
                    for i=1:testNum;
                        test = tests(i,:);
                        DM(i,:) = distMATChiSquare(trains,test)';
                    end
                    CP=ClassifyOnNN(DM,Top_n_retrieval,Images_per_class);
                    fprintf('\nclassification accuracy: LTrP (original) is %0.3f %',CP*100);
                    
                    
                    Local_texture_feature = [LTrP_convex_up LTrP_convex_down LSP_convex_up LSP_convex_down] ;
                    trains = Local_texture_feature(trainIDs,:);
                    tests = Local_texture_feature(testIDs,:);
                    trainNum = size(trains,1);
                    testNum = size(tests,1);
                    DM = zeros(testNum,trainNum);
                    for i=1:testNum;
                        test = tests(i,:);
                        DM(i,:) = distMATChiSquare(trains,test)';
                    end
                    CP=ClassifyOnNN(DM,Top_n_retrieval,Images_per_class);
                    fprintf('\nclassification accuracy: LTrP (With histogram refinement) is %0.3f %',CP*100);
                    
                end
                
            case 'NRLBP'
                if image_idx == 1
                    fprintf('\n benchmarking Noise-resistant Local biniary pattern (NRLBP); Percentage completed :')
                end
                
                [NRLBP(image_idx,:),NRLBP_convex_up(image_idx,:),NRLBP_convex_down(image_idx,:)] = NRLBP_func(Gray,15,1.0045);
                
                if  image_idx == picNum
                    % classification test using NRLBP
                    trainIDs=1:picNum;
                    testIDs=1:picNum;
                    Top_n_retrieval=10;
                    
                    Local_texture_feature = NRLBP ;
                    trains = Local_texture_feature(trainIDs,:);
                    tests = Local_texture_feature(testIDs,:);
                    trainNum = size(trains,1);
                    testNum = size(tests,1);
                    DM = zeros(testNum,trainNum);
                    for i=1:testNum;
                        test = tests(i,:);
                        DM(i,:) = distMATChiSquare(trains,test)';
                    end
                    CP=ClassifyOnNN(DM,Top_n_retrieval,Images_per_class);
                    fprintf('\nclassification accuracy: NRLBP (original) is %0.3f %',CP*100);
                    
                    
                    Local_texture_feature = [NRLBP_convex_up NRLBP_convex_down LSP_convex_up LSP_convex_down] ;
                    trains = Local_texture_feature(trainIDs,:);
                    tests = Local_texture_feature(testIDs,:);
                    trainNum = size(trains,1);
                    testNum = size(tests,1);
                    DM = zeros(testNum,trainNum);
                    for i=1:testNum;
                        test = tests(i,:);
                        DM(i,:) = distMATChiSquare(trains,test)';
                    end
                    CP=ClassifyOnNN(DM,Top_n_retrieval,Images_per_class);
                    fprintf('\nclassification accuracy: NRLBP (With histogram refinement) is %0.3f %',CP*100);
                    
                end
            otherwise
                error('Feature should be : LBP, LDP, LTrP, and NRLBP')
        end
        if ((image_idx > 1) && (image_idx < picNum))
            fprintf(repmat('\b',1,length(num2str(picNum))+length(num2str(image_idx))+4));
        end
    end
end