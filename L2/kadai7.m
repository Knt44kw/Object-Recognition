 %n=0;
  list={};
  LIST={'cat' 'dog' 'elephant' 'fish' 'horse' 'lion' 'penguin' 'tiger' 'whale' 'wildcat'};
  DIR0='/usr/local/class/object/animal/';
  for i=1:length(LIST)
    DIR=strcat(DIR0,LIST(i),'/');
    W=dir(DIR{:});

    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
	%n=n+1;
        %fprintf('[%d] %s\n',n,fn);
	list={list{:} fn};
      end
    end
  end
  
  database=[];
  for i=1:length(list)
     X=imread(list{i});
     Xred=X(:,:,1);
     Xgreen=X(:,:,2);
     Xblue=X(:,:,3);
     X64=floor(double(Xred)/64) *4*4 + floor(double(Xgreen)/64) *4 + floor(double(Xblue)/64);
 
     X64_reshaped=reshape(X64,1,numel(X64));
     h=histc(X64_reshaped,[0:63]);
     h=h/sum(h);
     database=[database;h];
  end
  
  load('db.mat'); 
  Nval='What number of images do you want to search by histogram N(1~1000) :';
  N=input(Nval);
  
  query=database(N,:);
  
  sim=[];
  for i=1:size(database,1)
     sim=[sim sum(min(database(i,:),query))];
  end
  
  [sorted,index]=sort(sim,'descend');
  
  
  subplot(1,4,1),imshow(imread(list{index(1)}));%クエリとなる画像を表示
  %類似する上位3枚の画像を表示
  subplot(1,4,2),imshow(imread(list{index(2)}));
  subplot(1,4,3),imshow(imread(list{index(3)}));
  subplot(1,4,4),imshow(imread(list{index(4)}));
  
  %クエリと上位3枚の画像との類似度を表示
  for i=2:4
      disp(sorted(i));
  end
  
  %コンソール上の実行例
% What number of images do you want to search by histogram N(1~1000) :512
%    0.8845

%    0.8801

%    0.8727
  
  %いくつか実行してみて
  %単純にヒストグラムで類似度を比較しているだけなので,画像の背景にも影響されるので
  %当たり前だが必ずしもクエリと同じカテゴリーの
  %動物が表示されるわけではないことも改めて確認できた.
  
  
  
  
  