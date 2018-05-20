function path=Index2path(index,branching_factor,depth)

path=ones(depth,1);
for i=depth:-1:1
    
    path(i)=mod(index-1,branching_factor)+1;
    index=floor((index-1)/branching_factor)+1;
    
end
    

