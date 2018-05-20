function [candidates,all_voting_scores]=Retrieve_best_candidates(I,vocabulary_tree,ifindex)

%DoG and SIFT descriptors of I
[~,sift_descriptors] = vl_sift(single(rgb2gray(I)));
number_of_descriptors = size(sift_descriptors,2);
all_voted_images = [];
all_voting_scores= zeros(1,99);
% [];

for sdi = 1:number_of_descriptors %... each descriptor in image i
    %path_to_leaf...
    path_to_leaf = vl_hikmeanspush(vocabulary_tree,sift_descriptors(:,sdi));
    index = Path2index(path_to_leaf,vocabulary_tree.K);
    %for each image in ifindex(index).images
    for i=1:length(ifindex(index).images)
        %cast a vote: add (if not yet encountered) or increment the corresponding
        %image score in all_voting_scores
        pos = find(all_voted_images & all_voted_images==ifindex(index).images(i),1);
        if  ~isempty(pos)
            if ~isempty(all_voting_scores)
                if(~isempty(ifindex(index).scores))
                    all_voting_scores(pos) = ifindex(index).scores(i) + all_voting_scores(pos);
                end
            else
                all_voting_scores(pos) = ifindex(index).scores(i);
            end
        else
            if(ifindex(index).images(i)>0)
            all_voted_images(end+1) = ifindex(index).images(i);
            end
        end
    end
    
end
%sort candidates (all_voted_images) according to descending all_voting_scores
%with sort Matlab command
[all_voting_scores,indices] = sort(all_voting_scores,'descend');
candidates = all_voted_images(indices);
fprintf('Image %d - score %g\n',[candidates(1:min(10,numel(candidates)));all_voting_scores(1:min(10,numel(all_voting_scores)))]);

end


