addpath('/usr/local/class/object/MATLAB/sift');
load('codebook.mat','codebook');
load('BoVW.mat','bovw');

%分類率が50%のまま変わらなかったので,このままでは結果にならないと判断し
%課題解答のmk_code.mのcodeの内容をcode.matとして保存した内容を利用する.
BoVW=transpose(bovw);%200*500(ポジネガ合わせて200枚*500(コードブックサイズ)の行列に転置)

dist=squareform(pdist(BoVW(1:200,:)));

correct=0;
incorrect=0;

dist=dist + 10000*eye(size(dist));

for i=1:100
  [v idx1]=min(dist(i,:));
  if idx1<=100 
    correct=correct+1;
  else
    incorrect=incorrect+1;
  end
end

for i=101:200
  [v idx2]=min(dist(i,:));
  if idx2<=100 
    incorrect=incorrect+1;
  else
    correct=correct+1;
  end
end
 
fprintf('classification rate: %.5f\n',correct/(correct+incorrect));

%{

classification rate: 0.88500
%}