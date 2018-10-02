
run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
addpath('/usr/local/class/object/MATLAB/sift');

  pos_lst={};
  neg_lst={};
  LIST1={'dog' 'elephant' 'fish' 'horse' 'lion' 'penguin' 'tiger' 'whale' 'wildcat'};
  LIST2={'cat'};
  DIR0='/usr/local/class/object/animal/';
  
  %ネガティブ画像リスト
  for i=1:length(LIST1)
    DIR=strcat(DIR0,LIST1(i),'/');
    W=dir(DIR{:});
    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
	    neg_lst={neg_lst{:} fn};
      end
    end
  end
  
  %ポジティブ画像リスト
  for i=1:length(LIST2)
    DIR=strcat(DIR0,LIST2(i),'/');
    W=dir(DIR{:});
    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
	    pos_lst={pos_lst{:} fn};
      end
    end
  end
  

%ネガティブ画像
neg=randperm(900,100);
neg_for_tst=neg_lst(:,neg);%ネガティブ画像100枚にするようにする

code_lst=[pos_lst neg_for_tst];
code_vec=[];

for i=1:length(code_lst)
  I=im2double(rgb2gray(imread(code_lst{i})));
  fprintf('reading [%d] %s\n',i,code_lst{i});
  [pnt,desc]=sift_rand(I,'randn',300);
  code_vec=[code_vec,desc];  
end

rp=randperm(size(code_vec,2));
code_vec_apply=code_vec(:,rp(1:50000));

[codebook,idx]=vl_kmeans(code_vec_apply,500);

save('codebook.mat','codebook');
save('flielist.mat','code_lst');

