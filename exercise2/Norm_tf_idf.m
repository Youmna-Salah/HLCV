function ifindex=Norm_tf_idf(ifindex,features_per_image,nImgs)
% Normalize ifindex with tf-idf
for i = 1:size(ifindex,2)
    N = nImgs;
    Ni = nnz(ifindex(i).images);
    if(Ni == 0)
        continue;
    end
    for j = 1:nImgs
        if isempty(ifindex(i).scores)
            break;
        end
        if(ifindex(i).scores(j)== 0)
            continue;
        end
        nd = features_per_image(j);
        ndi = ifindex(i).scores(j);
        ifindex(i).scores(j) = log(N/Ni)*(ndi/nd);
    end
    
end