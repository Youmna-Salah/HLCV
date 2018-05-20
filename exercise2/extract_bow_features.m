function [bowFeatures,labels] = extract_bow_features(inp_dir, codebook, printonscreen)

if ( (~exist('printonscreen','var')) || (isempty(printonscreen)) )
    printonscreen=false; 
end

% TODO:
%List of images (*.jpg)
%vImgNames = dir ...;

nImgs = length(vImgNames);
assert(nImgs > 0);
fprintf('%d images\n', nImgs);

% Initialize bow features. Each row contains feature for one image.
bowFeatures = zeros(nImgs, size(codebook,2));
labels = zeros(nImgs,1);

% Extract features for all images
for i=1:nImgs
    
    % Create label.
    if strfind(vImgNames(i).name,'dog')
        labels(i) = 1 ;
    else
        labels(i) = -1 ;
    end
    
    % TODO:
    % load the image
    %I=imread(fullfile(inp_dir,vImgNames(i).name));
    % convert to grayscale

    % TODO:
    %Use vl_sift to extract feature points with DoG and SIFT descriptors
    
    % TODO:
    %Assign each descriptor to one codebook entry. Assign to the closet one as per eucledean distance.
    % Then count how many descriptors have been assigned to each codebook entryStack all descriptors
    %bowFeatures(i,j) should be the number of descriptors from image i assigned to codebook entry j.

end
end
