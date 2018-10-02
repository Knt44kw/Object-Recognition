function code=mk_code()
 
  load('cbook.mat','codebook');
  load('list.mat','list');
  k=size(codebook,2);
 
  addpath('/usr/local/class/object/MATLAB/sift');
  
  code=[];
 
  for i=1:length(list)
    c=zeros(k,1);
    I=im2double(rgb2gray(imread(list{i})));
    fprintf('reading [%d] %s\n',i,list{i});
    [f d]=sift_rand(I,'randn',2000);
 
    for j=1:size(d,2)
      s=zeros(1,k);
      for t=1:128
        s=s+(codebook(t,:)-d(t,j)).^2;
       % disp(size(s));
      end
      [dist sidx]=min(s);
      c(sidx,1)=c(sidx,1)+1.0;
    end
    c=c/sum(c);
    code=[code c];
  end
  
  %size(code);
  save('code.mat','code');