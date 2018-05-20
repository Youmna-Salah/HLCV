function codebook = Create_codebook(vocab_dir, vocab_size, printonscreen)


if ( (~exist('vocab_size','var')) || (isempty(vocab_size)) )
    vocab_size=1000;
end
if ( (~exist('printonscreen','var')) || (isempty(printonscreen)) )
    printonscreen=false; 
end

%List of images
% TODO:
%List of images (*.jpg)
%vImgNames = dir ...;

nImgs = length(vImgNames);
assert(nImgs > 0);
fprintf('%d images\n', nImgs);

%Reserve memory: sizeof(uint8) * 128 * MAX_FEATURE_COUNT
MAX_FEATURE_COUNT = 100000;
all_sift_desc =  zeros([128,MAX_FEATURE_COUNT], 'uint8');

% Extract features for all images
for i=1:nImgs
    fprintf('Vocab tree creation: processing image %d, %s\n', i, vImgNames(i).name);

    % TODO:
    % load the image
    %I=imread(fullfile(inp_dir,vImgNames(i).name));
    % convert to grayscale

    % TODO:
    %Use vl_sift to extract feature points with DoG and SIFT descriptors
    
end

%Clear unused preallocated memory
all_sift_desc( :, (all_feature_count + 1):end ) = [];

fprintf('Number of extracted features: %d\n', size(all_sift_desc, 2));

% Cluster the features using K-Means
fprintf('Codebook creation: flat clustering...\n');
%TODO:
%Use vl_kmeans to create codebook
%[codebook, ~] = vl_kmeans(...

