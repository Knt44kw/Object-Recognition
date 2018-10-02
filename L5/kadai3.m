
load('code.mat','code');

BoF=transpose(code);

bof_pos=BoF(1:100,:);
bof_neg=BoF(101:200,:);

data=[bof_pos; bof_neg];
mapped_data=repmat(sqrt(abs(data)).*sign(data),[1 3]).*[0.8*ones(size(data)) 0.6*cos(0.6*log(abs(data)+eps)) 0.6*sin(0.6*log(abs(data)+eps))];

training_data=mapped_data;
training_label=[ones(100,1);ones(100,1)*(-1)];

%同じ学習データを使い学習
test_data=training_data;
test_label=training_label;

%線形SVM
tic;
  model_linear=fitcsvm(training_data,training_label,'KernelFunction','linear');
  [predicted_label,scores]=predict(model_linear,test_data);
toc;

correct_lin=numel(find((predicted_label .* test_label)==1));
incorrect_lin=numel(find((predicted_label .* test_label)==-1));

correct_rate_lin=correct_lin/(incorrect_lin+correct_lin);

fprintf('Classification rate by linear SVM in Feature Maps method %.5f \n',correct_rate_lin);

%非線形SVM
tic;
  model_nlinear=fitcsvm(training_data,training_label,'KernelFunction','rbf','KernelScale','auto');
  [predicted_label2,scores2]=predict(model_nlinear,test_data);
toc;

correct_nlin=numel(find((predicted_label2 .* test_label)==1));
incorrect_nlin=numel(find((predicted_label2 .* test_label)==-1));

correct_rate_nlin=correct_nlin/(incorrect_nlin+correct_nlin);

fprintf('Classification rate %.5f by non-linear SVM in Feature Maps method \n',correct_rate_nlin);

%{
実行例

経過時間は 0.094351 秒です。
Classification rate by linear SVM in Feature Maps method 0.94000 
経過時間は 0.115206 秒です。
Classification rate 0.99000 by non-linear SVM in Feature Maps method 
%}
