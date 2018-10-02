addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
load('list.mat','list');
vl_setupnn;

net = load('imagenet-caffe-alex.mat') ;

fc6=[];
fc7=[];
fc8=[];

for i=1:length(list)
im = imread(list{i});
im_ = single(im); 
im_ = imresize(im_, net.meta.normalization.imageSize(1:2));
im_ = im_ - net.meta.normalization.averageImage;

res = vl_simplenn(net, im_);

dcnnf_fc6=squeeze(res(end-5).x);
dcnnf_fc6=dcnnf_fc6/norm(dcnnf_fc6);
fc6=[fc6 dcnnf_fc6];


dcnnf_fc7=squeeze(res(end-3).x);
dcnnf_fc7=dcnnf_fc7/norm(dcnnf_fc7);
fc7=[fc7 dcnnf_fc7];

dcnnf_fc8=squeeze(res(end-1).x);
dcnnf_fc8=dcnnf_fc8/norm(dcnnf_fc8);
fc8=[fc8 dcnnf_fc8];
end

%順にfc6,fc7,fc8
fc_layer1=transpose(fc6);
fc_layer2=transpose(fc7);
fc_layer3=transpose(fc8);


%各レイヤーのポジネガを抽出
fc6_pos=fc_layer1(1:100,:);
fc6_neg=fc_layer1(101:200,:);
fc7_pos=fc_layer2(1:100,:);
fc7_neg=fc_layer2(101:200,:);
fc8_pos=fc_layer3(1:100,:);
fc8_neg=fc_layer3(101:200,:);


cv=5;
n=100;
idx=[1:n];
accuracy_fc6=[];
accuracy_fc7=[];
accuracy_fc8=[];

for i=1:cv  
  
  eval_pos =fc6_pos(find(mod(idx,cv)==(i-1)),:);
  train_pos=fc6_pos(find(mod(idx,cv)~=(i-1)),:);
  eval_neg =fc6_neg(find(mod(idx,cv)==(i-1)),:);
  train_neg=fc6_neg(find(mod(idx,cv)~=(i-1)),:);

  train=[train_pos; train_neg];
  eval=[eval_pos; eval_neg];
 
  train_label=[ones(size(train_pos,1),1); ones(size(train_neg,1),1)*(-1)];
  eval_label =[ones(size(eval_pos,1),1); ones(size(eval_neg,1),1)*(-1)];
  
  model=fitcsvm(train,train_label,'KernelFunction','linear');
  [predicted_label,scores]=predict(model,eval);
  
  correct=numel(find((predicted_label .* eval_label)==1));
  incorrect=numel(find((predicted_label .* eval_label)==-1));

  correct_rate=correct/(incorrect+correct);
  accuracy_fc6=[accuracy_fc6 correct_rate];
end


for i=1:cv
  eval_pos =fc7_pos(find(mod(idx,cv)==(i-1)),:);
  train_pos=fc7_pos(find(mod(idx,cv)~=(i-1)),:);
  eval_neg =fc7_neg(find(mod(idx,cv)==(i-1)),:);
  train_neg=fc7_neg(find(mod(idx,cv)~=(i-1)),:);

  eval=[eval_pos; eval_neg];
  train=[train_pos; train_neg];

  eval_label =[ones(size(eval_pos,1),1); ones(size(eval_neg,1),1)*(-1)];
  train_label=[ones(size(train_pos,1),1); ones(size(train_neg,1),1)*(-1)];
  
 
  
  model=fitcsvm(train,train_label,'KernelFunction','linear');
  [predicted_label,scores]=predict(model,eval);
  
  correct=numel(find((predicted_label .* eval_label)==1));
  incorrect=numel(find((predicted_label .* eval_label)==-1));

  correct_rate=correct/(incorrect+correct);
  accuracy_fc7=[accuracy_fc7 correct_rate];
end

for i=1:cv
  eval_pos =fc8_pos(find(mod(idx,cv)==(i-1)),:);
  train_pos=fc8_pos(find(mod(idx,cv)~=(i-1)),:);
  eval_neg =fc8_neg(find(mod(idx,cv)==(i-1)),:);
  train_neg=fc8_neg(find(mod(idx,cv)~=(i-1)),:);

  eval=[eval_pos; eval_neg];
  train=[train_pos; train_neg];

  eval_label =[ones(size(eval_pos,1),1); ones(size(eval_neg,1),1)*(-1)];
  train_label=[ones(size(train_pos,1),1); ones(size(train_neg,1),1)*(-1)];
  
  model=fitcsvm(train,train_label,'KernelFunction','linear');
  [predicted_label,scores]=predict(model,eval);
  
  correct=numel(find((predicted_label .* eval_label)==1));
  incorrect=numel(find((predicted_label .* eval_label)==-1));

  correct_rate=correct/(incorrect+correct);
  accuracy_fc8=[accuracy_fc8 correct_rate];
end

fprintf('accuracy fc6: %f\n',mean(accuracy_fc6));
fprintf('accuracy fc7: %f\n',mean(accuracy_fc7));
fprintf('accuracy fc8: %f\n',mean(accuracy_fc8));

%{
分類率が高すぎるので改善の余地があると思うのだが現時点で検討がついていないのでこのまま提出する.
(読み込んだ画像リストが簡単すぎた可能性もあるかも知れないが)
accuracy fc6: 0.990000
accuracy fc7: 1.000000
accuracy fc8: 1.000000
%}



