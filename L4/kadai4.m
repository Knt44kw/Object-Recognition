addpath('/usr/local/class/object/MATLAB/sift');
load('codebook.mat','codebook');
load('filelist.mat','code_lst');

  %コードブックサイズ
  csize=size(codebook,2);
  %BoVWベクトル
  bovw=[];
  
  for j=1:length(code_lst)
   c=zeros(csize,1);
   I=im2double(rgb2gray(imread(code_lst{j})));
   fprintf('reading [%d] %s\n',j,code_lst{j});
   [pnt,desc]=sift_rand(I,'randn',2000);
     for i=1:size(desc,2)
             d=zeros(1,csize);
             for k=1:128
               d=d+(codebook(k,:)-desc(k,i)).^2;
             end
             min_idx=size(min(d),2);
             c(min_idx,1)=c(min_idx,1)+1;
       end
      c=c/sum(c);
      bovw=[bovw c];
  end
  
  save('BoVW.mat','bovw');
  

  
  
  