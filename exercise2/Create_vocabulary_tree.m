function vocabulary_tree=Create_vocabulary_tree(vocab_dir, branching_factor, min_vocabulary_size)

%List of images (*.jpg)
%vImgNames = dir ...;

vImgNames = dir(strcat(vocab_dir,'\*.jpg'));
nImgs = length(vImgNames);
assert(nImgs > 0);
fprintf('%d images\n', nImgs);

%Reserve memory for all_sift_desc: sizeof(uint8) * 128 * MAX_FEATURE_COUNT
MAX_FEATURE_COUNT = 100000;
all_sift_desc =  zeros([128,MAX_FEATURE_COUNT], 'uint8');

% Extract features for all images
start = 1;
all_feature_count = 0;
for i=1:nImgs
    I=imread(fullfile(vocab_dir,vImgNames(i).name));
    img= single ( rgb2gray( I ) );
    [sift_frames,cur_sift_desc] = vl_sift(img);
    all_sift_desc(:,start:start+size(cur_sift_desc,2)-1) = cur_sift_desc;
    all_feature_count = all_feature_count + size(cur_sift_desc,2);
    start = all_feature_count + 1;
end

    
%Clear unused preallocated memory
all_sift_desc( :, (all_feature_count + 1):end) = [];

fprintf('Number of extracted features: %d\n', size(all_sift_desc, 2));

% Cluster the features Hierarchical K-Means
fprintf('Vocab tree creation: clustering...\n');

[vocabulary_tree] = vl_hikmeans(all_sift_desc, branching_factor, min_vocabulary_size);



