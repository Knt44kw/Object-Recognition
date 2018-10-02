run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
  list={};
  LIST={'cat' 'dog' 'elephant' 'fish' 'horse' 'lion' 'penguin' 'tiger' 'whale' 'wildcat'};
  DIR0='/usr/local/class/object/animal/';
  for i=1:length(LIST)
    DIR=strcat(DIR0,LIST(i),'/');
    W=dir(DIR{:});
    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
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
     h=h./sum(h);
     database=[database;h];
  end
  
  sel=randperm(1000,100);
  rand_imgs=database(sel,:);
  rand_list=list(sel);
  
  %vlkmeansによるクラスタリング開始
  tic;
  [C,IDX]=vl_kmeans(rand_imgs,5);
  fprintf('vlkmeans clustering by five cluster took %.3f \n',toc);
  
  tic;
  [C2,IDX2]=vl_kmeans(rand_imgs,10);
  fprintf('vlkmeans clustering by ten cluster took %.3f \n',toc);
  
  
  %クラスタ番号1~5に相当する画像を探索
  vlkmeans_group1=find(IDX==1);
  vlkmeans_group2=find(IDX==2);
  vlkmeans_group3=find(IDX==3);
  vlkmeans_group4=find(IDX==4); 
  vlkmeans_group5=find(IDX==5); 
 
  %各画像の数を抽出したリスト
  sizelst={size(vlkmeans_group1,2),size(vlkmeans_group2,2),size(vlkmeans_group3,2),size(vlkmeans_group4,2),size(vlkmeans_group5,2)};
  sizelst %画像の数を表示
  
  %画像の表示を10枚程度に抑える
  for i=1:size(sizelst,2)
    if sizelst{i}>10
       sizelst{i}=10;
    end
  end
  
  figure;
  for i=1:sizelst{1}
     subplot(4,3,i),imshow(imread(char(rand_list(vlkmeans_group1(i)))));
  end
  
  fig2=figure;
  for i=1:sizelst{2}
     subplot(4,3,i),imshow(imread(char(rand_list(vlkmeans_group2(i)))));
  end
  
  fig3=figure;
  for i=1:sizelst{3}
     subplot(4,3,i),imshow(imread(char(rand_list(vlkmeans_group3(i)))));
  end
   
  fig4=figure;
  for i=1:sizelst{4}
     subplot(4,3,i),imshow(imread(char(rand_list(vlkmeans_group4(i)))));
  end
   
  fig5=figure;
   for i=1:sizelst{5}
     subplot(4,3,i),imshow(imread(char(rand_list(vlkmeans_group5(i)))));
   end
     
  tic;
  [IDX3,C3]=kmeans(rand_imgs,5);
  fprintf('kmeans clustering by five cluster took %.3f \n',toc);
  
  
  tic;
  [IDX4,C4]=kmeans(rand_imgs,10);
  fprintf('kmeans clustering by ten cluster took %.3f \n',toc);
  
  %kmeansによるクラスタリング開始
  kmeans_group1=find(IDX3==1);
  kmeans_group2=find(IDX3==2);
  kmeans_group3=find(IDX3==3);
  kmeans_group4=find(IDX3==4);
  kmeans_group5=find(IDX3==5);
  
  size_klst={size(kmeans_group1,2),size(kmeans_group2,2),size(kmeans_group3,2),size(kmeans_group4,2),size(kmeans_group5,2)};
  %画像の数を表示
  size_klst 
  
  for i=1:size(size_klst,2)
    if size_klst{i}>10
       size_klst{i}=10;
    end
  end
  
  %kmeansクラスタリングによる分類結果の表示
  fig6=figure;
  for i=1:size_klst{1}
     subplot(4,3,i),imshow(imread(char(rand_list(kmeans_group1(i)))));
  end
  
  fig7=figure;
  for i=1:size_klst{2}
     subplot(4,3,i),imshow(imread(char(rand_list(kmeans_group2(i)))));
  end
  
  fig8=figure;
  for i=1:size_klst{3}
     subplot(4,3,i),imshow(imread(char(rand_list(kmeans_group3(i)))));
  end
  
  fig9=figure;
  for i=1:size_klst{4}
     subplot(4,3,i),imshow(imread(char(rand_list(kmeans_group4(i)))));
  end
  
  fig10=figure;
  for i=1:size_klst{5}
     subplot(4,3,i),imshow(imread(char(rand_list(kmeans_group5(i)))));
  end

  %実行例
 % vlkmeans clustering by five cluster took 0.002 
 % vlkmeans clustering by ten cluster took 0.001 

%sizelst =

%  1×5 の cell 配列

%    [4]    [55]    [2]    [1]    [2]

%kmeans clustering by five cluster took 0.014 
%kmeans clustering by ten cluster took 0.017 

%size_klst =

%  1×5 の cell 配列

%    [1]    [1]    [1]    [1]    [1]
  