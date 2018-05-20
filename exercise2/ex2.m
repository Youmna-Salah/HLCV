show_q1 = true;
show_q2 = true;
show_q3 = true;
show_q4 = true;

%vl_feat toolbox
addpath('./vlfeat-0.9.14/toolbox/kmeans');
addpath('./vlfeat-0.9.14/toolbox/sift');
addpath('./vlfeat-0.9.14/toolbox/mser'); %*
addpath('./vlfeat-0.9.14/toolbox/plotop'); %*
addpath(['./vlfeat-0.9.14/toolbox/mex/' mexext]);

%Setup: data folders
vocab_dir='./Covers_train';
dataset_dir='./Covers_train';
test_dir='./Covers_test';

%Setup: tree parameters
branching_factor=8;
min_vocabulary_size=4096;

%% Question 1: Vocabulary tree generation%
if show_q1
    
    vocabulary_tree=Create_vocabulary_tree(vocab_dir, branching_factor, min_vocabulary_size);
    
    %Recursively count the effectively assigned leaves
    number_of_leaves=Countleaves(vocabulary_tree);
    fprintf('Number of leaves %d\n',number_of_leaves);
    
    %Visualize feature patches represented with the same visual word
    %random_path=randi ...; %random path to a leaf node, each leaf is a visual word
    random_path=[7 6 6 2];
    %     Show_visual_word(random_path,vocab_dir,vocabulary_tree);
end

%% Question 2: Inverted file index tree generation
if show_q2
    [features_per_image,nImgs,ifindex]=Invert_file_index(dataset_dir,vocabulary_tree);
    %%
    ifindex2=Norm_tf_idf(ifindex,features_per_image,nImgs);
end


%% Question 3: Retrieval of best candidate with vocabulary tree and scoring%
if show_q3
    printonscreen=true; %this allows visualization of the matched correspondences
    
    %Load one image
    test_image=1; %First image in directory
    tImgNames = dir(fullfile(test_dir, '*.jpg'));
    
    I=imread(fullfile(test_dir,tImgNames(test_image).name));
    fprintf('\nTest image %d: %s\n',test_image,tImgNames(test_image).name);
    
    %Retrieve candidates with inverted file index tree
    [candidates,scores]=Retrieve_best_candidates(I,vocabulary_tree,ifindex);
    
    if (printonscreen)
        %Show first 9 candidates
        figure(5), clf;
        imagesc(I);
        axis off; set(gcf, 'color', 'white');
        title(['Image ',num2str(test_image)]);
        Show_some_candidates(dataset_dir,candidates,scores);
    end
    
    %% This is the code for q3 e)
    how_many_test=100;
    all_test_images=1:min(how_many_test,length(tImgNames));
    
    retriev_accuracy=0;
    for i=1:numel(all_test_images)
        test_image=all_test_images(i);
        I=imread(fullfile(test_dir,tImgNames(test_image).name));
        fprintf('\nTest image %d: %s\n',test_image,tImgNames(test_image).name);
        
        %Retrieve candidates with inverted file index tree
        [candidates,scores]=Retrieve_best_candidates(I,vocabulary_tree,ifindex);
        
        %increase retriev_accuracy score if the best candidate matches the
        %test_image (using its position in the folder for ground truth)
        if~isempty(find(candidates, test_image))
            retriev_accuracy = retriev_accuracy +1;
        end
    end
    retriev_accuracy=retriev_accuracy/numel(all_test_images);
    fprintf('Mean retrieval accuracy %g\n',retriev_accuracy);
    
end



%
% Question 4: SVM based classification
%
if show_q4
    vocab_dir='./st10_train';
    train_dir='./st10_train';
    test_dir='./st10_test';
    vocabulary_size=100;
    
    codebook = Create_codebook(vocab_dir, vocabulary_size); %, printonscreen
    
    % Extract descriptors from each image in the folder and and calculate bow features.
    [features_train, lbl_train] = extract_bow_features(train_dir, codebook );
    
    model = []; %use fitcsvm to build your model on the training set data.
    
    % Extract features on the test set.
    [features_test, lbl_test] = extract_bow_features(test_dir, codebook);
    
    predictTrain  = zeros(size(lbl_train)); % Fill this with predictions from the SVM model on the training set
    predictTest = zeros(size(lbl_train)); % Fill this with predictions from the SVM model on the test set
    
    fprintf('Training set accuracy is %.2f\n',100.0*double(sum(predictTrain ==lbl_train))/double(length(lbl_train)));
    fprintf('Test set accuracy is %.2f\n',100.0*double(sum(predictLabel ==lbl_test))/double(length(lbl_test)));
    
end
