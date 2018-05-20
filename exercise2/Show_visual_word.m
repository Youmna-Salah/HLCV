function Show_visual_word(path_to_leaf,vocab_dir,vocabulary_tree)
%Visualize the first Nfeatpatches feature patches (from all images in vocab_dir)
%represented by the visual word path_to_leaf

Nfeatpatches=3;

%...

vImgNames = dir(strcat(vocab_dir,'\*.jpg'));
nImgs = length(vImgNames);
assert(nImgs > 0);
fprintf('%d images\n', nImgs);


patches_count = 1;
for i=1:nImgs
    I=imread(fullfile(vocab_dir,vImgNames(i).name));
    img= single ( rgb2gray( I ) );
    [sift_frames,cur_sift_desc] = vl_sift(img);
    for j=1:size(cur_sift_desc,2)
        path_to_leaf2 = vl_hikmeanspush(vocabulary_tree,cur_sift_desc(:,j));
        if path_to_leaf2 == transpose(path_to_leaf)
            subplot(1,Nfeatpatches,patches_count);
            half_scaled_patch_size = floor(6*sift_frames(3,j)/2);
            x_center = floor(sift_frames(1,j));
            y_center = floor(sift_frames(2,j));
            half_cropped_patch_size = get_patch_size(size(img,2),size(img,1),x_center,y_center,half_scaled_patch_size);
            img2 = rgb2gray(I);
            patch = img2( y_center-half_cropped_patch_size:y_center+half_cropped_patch_size, x_center-half_cropped_patch_size: x_center+half_cropped_patch_size );
            imshow(patch);
            title(sprintf('Image name: %s\nwith orientation: %f',vImgNames(i).name,sift_frames(4,j)));
            patches_count = patches_count + 1;
            if (patches_count > Nfeatpatches)
                return 
            end
        end
    end
end



