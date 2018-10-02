function [desc codebook]=mk_codebook_sift()
 
  k=500;
  addpath('/usr/local/class/object/MATLAB/sift');
  run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
 
  list=flist();
  pos_idx=[1:100];
  neg_idx=randperm(900,100)+100; 
  list=list([pos_idx neg_idx]);

  desc=[];
  for i=1:length(list)
    I=im2double(rgb2gray(imread(list{i})));
    fprintf('reading [%d] %s\n',i,list{i});
    [f d]=sift_rand(I,'threshold',0.04);
    desc=[desc d];
  end
 
  [codebook, idx]=vl_kmeans(desc,k);
  save('codebook_sift.mat','codebook');
 
end
  
