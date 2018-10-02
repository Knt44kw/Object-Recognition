addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
load('filelist.mat','code_lst');
vl_setupnn;

net = load('imagenet-caffe-alex.mat') ;

DCNN=[];%DCNN特徴量を格納するリスト

for i=1:length(code_lst)
im = imread(code_lst{i});
im_ = single(im); 
im_ = imresize(im_, net.meta.normalization.imageSize(1:2));
im_ = im_ - net.meta.normalization.averageImage;

res = vl_simplenn(net, im_);

dcnnf=squeeze(res(end-3).x);
dcnnf=dcnnf/norm(dcnnf);
DCNN=[DCNN dcnnf];
end

save('DCNN.mat','DCNN');
load('DCNN.mat','DCNN');

dcnn=transpose(DCNN);

dcnn_pos=dcnn(1:100,:);
dcnn_neg=dcnn(101:200,:);

data=[dcnn_pos; dcnn_neg];
mapped_data=repmat(sqrt(abs(data)).*sign(data),[1 3]).*[0.8*ones(size(data)) 0.6*cos(0.6*log(abs(data)+eps)) 0.6*sin(0.6*log(abs(data)+eps))];


training_data=mapped_data;
training_label=[ones(100,1);ones(100,1)*(-1)];

test_data=training_data;
test_label=training_label;

fprintf('Linear SVM\n');
%線形SVM
tic;
  model_linear=fitcsvm(training_data,training_label,'KernelFunction','linear');
  [predicted_label,scores]=predict(model_linear,test_data);
toc;

correct_lin=numel(find((predicted_label .* test_label)==1));
incorrect_lin=numel(find((predicted_label .* test_label)==-1));

correct_rate_lin=correct_lin/(incorrect_lin+correct_lin);

fprintf('Classification rate by linear SVM (Dataset DCNN) %.5f \n',correct_rate_lin);

fprintf('Non-linear SVM\n');
%非線形SVM
tic;
  model_nlinear=fitcsvm(training_data,training_label,'KernelFunction','rbf','KernelScale','auto');
  [predicted_label2,scores2]=predict(model_nlinear,test_data);
toc;

correct_nlin=numel(find((predicted_label2 .* test_label)==1));
incorrect_nlin=numel(find((predicted_label2 .* test_label)==-1));

correct_rate_nlin=correct_nlin/(incorrect_nlin+correct_nlin);

fprintf('Classification rate %.5f by non-linear SVM (Dataset DCNN) \n',correct_rate_nlin);

%{
実行例
%}