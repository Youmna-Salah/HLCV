function index=Path2index(path,branching_factor)

index=1;
for i=1:numel(path)
    
    index= (index-1)*branching_factor + path(i);
    
end


function Test_function() %#ok<DEFNU>

branching_factor=3;
depth=3;
nleaves=branching_factor^depth;
test_path=zeros(depth,nleaves);
for i=1:nleaves
    
    test_path(:,i)=Index2path(i,branching_factor,depth);
    
end

test_index=zeros(1,size(test_path,2));
for i=1:size(test_path,2)
    
    test_index(i)=Path2index(test_path(:,i),branching_factor);
    
end
