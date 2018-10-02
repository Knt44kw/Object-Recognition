
addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
load('filelist.mat','code_lst');
vl_setupnn;

net_lst = {load('imagenet-caffe-alex.mat'),load('imagenet-vgg-f.mat'), load('imagenet-vgg-verydeep-16.mat')} ;

caffe_alex_lst=[];
vgg_lst=[];
vgg_verydeep_lst=[];

%各ネットワークでのDCNN特徴の抽出にかかる時間を計測する.

tic
for i=1:length(code_lst)
im = imread(code_lst{i});
im_ = single(im); 
im_ = imresize(im_, net_lst{1}.meta.normalization.imageSize(1:2));
im_ = im_ - net_lst{1}.meta.normalization.averageImage;

res = vl_simplenn(net_lst{1}, im_);

dcnnf=squeeze(res(end-3).x);
dcnnf=dcnnf/norm(dcnnf);
caffe_alex_lst=[caffe_alex_lst dcnnf];
end
fprintf('it took %f in AlexNet\n',toc);

tic
for i=1:length(code_lst)
im = imread(code_lst{i});
im_ = single(im); 
im_ = imresize(im_, net_lst{2}.meta.normalization.imageSize(1:2));
im_ = im_ - net_lst{2}.meta.normalization.averageImage;

res = vl_simplenn(net_lst{2}, im_);

dcnnf=squeeze(res(end-3).x);
dcnnf=dcnnf/norm(dcnnf);
vgg_lst=[vgg_lst dcnnf];
end
fprintf('it took %f in vgg-f\n',toc);

tic
for i=1:length(code_lst)
im = imread(code_lst{i});
im_ = single(im); 
im_ = imresize(im_, net_lst{3}.meta.normalization.imageSize(1:2));
im_ = im_ - repmat(net_lst{3}.meta.normalization.averageImage,net_lst{3}.meta.normalization.imageSize(1:2));

res = vl_simplenn(net_lst{3}, im_);

dcnnf=squeeze(res(end-3).x);
dcnnf=dcnnf/norm(dcnnf);
vgg_verydeep_lst=[vgg_verydeep_lst dcnnf];
end
fprintf('it took %f in vgg-verydeep\n',toc);

caffe_alex_layer=transpose(caffe_alex_lst);
vgg_layer=transpose(vgg_lst);
vgg_verydeep_layer=transpose(vgg_verydeep_lst);


%各レイヤーのポジネガを抽出
alex_pos=caffe_alex_layer(1:100,:);
alex_neg=caffe_alex_layer(101:200,:);
vgg_pos=vgg_layer(1:100,:);
vgg_neg=vgg_layer(101:200,:);
vdeep_pos=vgg_verydeep_layer(1:100,:);
vdeep_neg=vgg_verydeep_layer(101:200,:);


cv=5;
n=100;
idx=[1:n];
accuracy_alex=[];
accuracy_vgg=[];
accuracy_vdeep=[];

for i=1:cv  
  
  eval_pos =alex_pos(find(mod(idx,cv)==(i-1)),:);
  train_pos=alex_pos(find(mod(idx,cv)~=(i-1)),:);
  eval_neg =alex_neg(find(mod(idx,cv)==(i-1)),:);
  train_neg=alex_neg(find(mod(idx,cv)~=(i-1)),:);

  eval=[eval_pos; eval_neg];
  train=[train_pos; train_neg];
  
  
  eval_label =[ones(size(eval_pos,1),1); ones(size(eval_neg,1),1)*(-1)];
  train_label=[ones(size(train_pos,1),1); ones(size(train_neg,1),1)*(-1)];
  
  size(train_label);
  
  model=fitcsvm(train,train_label,'KernelFunction','linear');
  [predicted_label,scores]=predict(model,eval);
  
  correct=numel(find((predicted_label .* eval_label)==1));
  incorrect=numel(find((predicted_label .* eval_label)==-1));

  correct_rate=correct/(incorrect+correct);
  accuracy_alex=[accuracy_alex correct_rate];
end


for i=1:cv
  eval_pos =vgg_pos(find(mod(idx,cv)==(i-1)),:);
  train_pos=vgg_pos(find(mod(idx,cv)~=(i-1)),:);
  eval_neg =vgg_neg(find(mod(idx,cv)==(i-1)),:);
  train_neg=vgg_neg(find(mod(idx,cv)~=(i-1)),:);

  eval=[eval_pos; eval_neg];
  train=[train_pos; train_neg];

  eval_label =[ones(size(eval_pos,1),1); ones(size(eval_neg,1),1)*(-1)];
  train_label=[ones(size(train_pos,1),1); ones(size(train_neg,1),1)*(-1)];
  
 
  
  model=fitcsvm(train,train_label,'KernelFunction','linear');
  [predicted_label,scores]=predict(model,eval);
  
  correct=numel(find((predicted_label .* eval_label)==1));
  incorrect=numel(find((predicted_label .* eval_label)==-1));

  correct_rate=correct/(incorrect+correct);
  accuracy_vgg=[accuracy_vgg correct_rate];
end

for i=1:cv
  eval_pos =vdeep_pos(find(mod(idx,cv)==(i-1)),:);
  train_pos=vdeep_pos(find(mod(idx,cv)~=(i-1)),:);
  eval_neg =vdeep_neg(find(mod(idx,cv)==(i-1)),:);
  train_neg=vdeep_neg(find(mod(idx,cv)~=(i-1)),:);

  eval=[eval_pos; eval_neg];
  train=[train_pos; train_neg];

  eval_label =[ones(size(eval_pos,1),1); ones(size(eval_neg,1),1)*(-1)];
  train_label=[ones(size(train_pos,1),1); ones(size(train_neg,1),1)*(-1)];
  
  model=fitcsvm(train,train_label,'KernelFunction','linear');
  [predicted_label,scores]=predict(model,eval);
  
  correct=numel(find((predicted_label .* eval_label)==1));
  incorrect=numel(find((predicted_label .* eval_label)==-1));

  correct_rate=correct/(incorrect+correct);
  accuracy_vdeep=[accuracy_vdeep correct_rate];
end

fprintf('accuracy alex: %f\n',mean(accuracy_alex));
fprintf('accuracy vgg: %f\n',mean(accuracy_vgg));
fprintf('accuracy vgg-verydeep: %f\n',mean(accuracy_vdeep));

%{
第4回の練習問題3の結果として提出したコードブック生成で保存した画像リストcode_lst
により認識を行った. Very Deep NetWorkの性能の高さがうまく比較できていない形になってしまっているが
少なくとも高速版ネットワークで実行した場合が最も特徴抽出に要する時間が短く,高精度版のネットワークでは最も時間がかかっている
ということはわかる結果となった.

it took 19.495848 in AlexNet
it took 16.679061 in vgg-f
it took 85.429390 in vgg-verydeep
accuracy alex: 0.995000
accuracy vgg: 1.000000
accuracy vgg-verydeep: 1.000000

%}
