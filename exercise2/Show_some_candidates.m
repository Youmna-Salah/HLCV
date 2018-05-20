function Show_some_candidates(dataset_dir,candidates,scores)

vImgNames = dir(fullfile(dataset_dir, '*.png')); %TODO: png
if (length(vImgNames)<=0), vImgNames = dir(fullfile(dataset_dir, '*.jpg')); end
nImgs = length(vImgNames);
assert(nImgs > 0);

figure(6);
clf;

n = 3;
nsqr=n*n;

for i = 1:min(nsqr,numel(candidates))
    subplot(n, n, i);
    
    I=imread(fullfile(dataset_dir,vImgNames(candidates(i)).name));

    imagesc(I);
    set(gcf, 'color', 'white');
    axis off;
    title(['Score ',num2str(scores(i))]);
end
