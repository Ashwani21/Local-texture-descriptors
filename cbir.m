clear all;
close all;
clc;
%% Select Query image

[file,path,indx] = uigetfile( ...
    {'*.bmp;*.png;*.jpg',...
    'Select query image (*.png;*.jpg;*.bmp)';
    '*.m;*.mlx','Code files (*.jpg,*.mlx)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'Select query image');

img_path = fullfile(path,file);
disp(['Query image : ', img_path]);
file_class = strsplit(file,'.');
file_class = ceil((str2num(file_class{1})+1)/100);
%% Feature generation
% Generate histogram of LBP

base_root=pwd;

R=1;
P=8;
database = 'Corel';

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

%% Find top n matches
% Load pre-calculated texture features
load('local_features_corel.mat')

trainIDs=1:picNum;
testIDs=1:picNum;
Top_n_retrieval=10;

img_collage_all = [];
precision = zeros(1,8);
for feature_idx = 1:4
    img_collage = [];
    switch feature_idx
        case 1
            Local_textures = LBP;
            Local_textures_convex_up = LBP_convex_up;
            Local_textures_convex_down = LBP_convex_down;
        case 2
            Local_textures = LDP;
            Local_textures_convex_up = LDP_convex_up;
            Local_textures_convex_down = LDP_convex_down;
        case 3
            Local_textures = LTrP;
            Local_textures_convex_up = LTrP_convex_up;
            Local_textures_convex_down = LTrP_convex_down;
        case 4
            Local_textures = NRLBP;
            Local_textures_convex_up = NRLBP_convex_up;
            Local_textures_convex_down = NRLBP_convex_down;
    end
    
    database = Local_textures;
    trainNum = size(database,1);
    testNum = size(database,1);
    DM = zeros(testNum,trainNum);
    
    query = strsplit(img_path,'image.orig');
    image_name = query{2};
    image_name = image_name(2:end);
    image_name = strsplit(image_name,'.');
    image_name = str2num(image_name{1})+1; % +1 is for corel as image start from 0
    
    query_image = database(image_name,:);
    match_score = distMATChiSquare(database,query_image)'; % Calculate L1 similarity measure
    
    DM_sorted=sort(match_score);  
    Max_dist=DM_sorted(Top_n_retrieval);
    Retrieved_objects =trainIDs((match_score<=Max_dist))-1; % In Corel dataset image index start from 0
    Retrieved_relevant = match_score(match_score<=Max_dist);
    sorted_relevence = sort(Retrieved_relevant);
    
    Retrieved_objects_p = zeros(1,10);
    for idx = 1:Top_n_retrieval
        Retrieved_objects_p(idx) = Retrieved_objects(find(Retrieved_relevant == sorted_relevence(idx)));
    end
    Retrieved_objects = Retrieved_objects_p;
    
    %%% Histogram Refined
    Local_textures_histogram_refined = [Local_textures_convex_down Local_textures_convex_up]; % Histogram Refinement
    trains_histogram_refined = Local_textures_histogram_refined(trainIDs,:);
    
    test_histogram_refined = Local_textures_histogram_refined(image_name,:);
    match_score_histogram_refined = distMATChiSquare(trains_histogram_refined,test_histogram_refined)';
    
    DM_sorted_histogram_refined=sort(match_score_histogram_refined);
    Max_dist_histogram_refined=DM_sorted_histogram_refined(Top_n_retrieval);
    Retrieved_objects_refined =trainIDs((match_score_histogram_refined<=Max_dist_histogram_refined))-1; % In Corel dataset image index start from 0
    Retrieved_relevant = match_score_histogram_refined(match_score_histogram_refined<=Max_dist_histogram_refined);
    sorted_Retrieved_objects_histogram_refined = sort(Retrieved_relevant);
    
    Retrieved_objects_histogram_refined_p = zeros(1,10);
    for idx = 1:Top_n_retrieval
        Retrieved_objects_histogram_refined_p(idx) = Retrieved_objects_refined(find(Retrieved_relevant == sorted_Retrieved_objects_histogram_refined(idx)));
    end
    Retrieved_objects_histogram_refined = Retrieved_objects_histogram_refined_p;
    
    Retrieved_objects_class = ceil((Retrieved_objects+1)/100);
    Retrieved_objects_histogram_refined_class = ceil((Retrieved_objects_histogram_refined+1)/100);
    
    Pix_SS = [1 1 1366 768];
    resize_row = floor(Pix_SS(4)/Top_n_retrieval);
    resize_col = floor(Pix_SS(3)/Top_n_retrieval);
    
    Red_vert = ones(resize_row,10,3)*255;
    %     Red_vert(:,:,1) = 255;
    
    Red_hoz = ones(10,resize_col+20,3)*255;
    %     Red_hoz(:,:,1) = 255;
    
    Green_vert = zeros(resize_row,10,3);
    Green_vert(:,:,2) = 255;
    
    Green_hoz = zeros(10,resize_col+20,3);
    Green_hoz(:,:,2) = 255;
    
    White_hoz = ones(10,resize_col+20,3)*255;
    White_vert = ones(resize_row,10,3)*255;
    
    precision(2*feature_idx-1) = sum(file_class == Retrieved_objects_class)/Top_n_retrieval;
    precision(2*feature_idx) = sum(file_class == Retrieved_objects_histogram_refined_class)/Top_n_retrieval;
    
    for idx = 0:Top_n_retrieval+1
        if idx >= 1 && idx <= Top_n_retrieval
            Top_matches = [query{1},'image.orig/',num2str(Retrieved_objects(idx)),'.jpg']; % / for unix
            img = imread(Top_matches);
            Top_matches = [query{1},'image.orig/',num2str(Retrieved_objects_histogram_refined(idx)),'.jpg']; % / for unix
            img_histogram_refined = imread(Top_matches);
            
            if file_class == Retrieved_objects_class(idx)
                temp = [ Green_hoz;Green_vert imresize(img,[resize_row,resize_col]) Green_vert;Green_hoz];
            else
                temp = [ Red_hoz;Red_vert imresize(img,[resize_row,resize_col]) Red_vert;Red_hoz];
            end
            
            if file_class == Retrieved_objects_histogram_refined_class(idx)
                temp_refined = [Green_hoz; Green_vert imresize(img_histogram_refined,[resize_row,resize_col]) Green_vert;Green_hoz];
            else
                temp_refined = [Red_hoz; Red_vert imresize(img_histogram_refined,[resize_row,resize_col]) Red_vert;Red_hoz];
            end
            
        else
            
            img = ones(resize_row,resize_col,3)*255;
            img_histogram_refined = img;
            
            temp = [ White_hoz;[White_vert img White_vert];White_hoz];
            
            temp_refined = [White_hoz; [White_vert img_histogram_refined White_vert];White_hoz];
        end
        img_collage = [img_collage [temp;temp_refined]];
    end
    img_collage_all = [img_collage_all;img_collage];
end
%%
createfigure(img_collage_all,precision*100,resize_row,resize_col);