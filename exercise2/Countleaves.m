function number_of_leaves=Countleaves(parent)
%Function to count the vocabulary words, i.e. the number of
%cluster centroids at the leaves of the vocabulary tree.

if isempty(parent.sub) 
    number_of_leaves = length(parent.centers);
else
    for i=1:length(parent.sub)
        number_of_leaves = 0 + Countleaves(parent.sub(i));
    end
end


%A possible implementation is recursive:

%IF at a leaf node
%   count the centroids
%   ...
%ELSE
%   keep traversing the tree (call Countleaves iteratively) to the leaf nodes
%   ...
