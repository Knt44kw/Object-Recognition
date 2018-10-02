X_src=rand(100,100);
Vsum=sum(X_src);
SumMatrix=ones(100,1)*Vsum;
normalizedX=X_src./SumMatrix%要素ごとに各列に対して正規化を行う
disp(sum(normalizedX));%正規化した各列の和の表示

%実行例

% 1 列から 8 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  9 列から 16 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  17 列から 24 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  25 列から 32 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  33 列から 40 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  41 列から 48 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  49 列から 56 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  57 列から 64 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  65 列から 72 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  73 列から 80 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  81 列から 88 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  89 列から 96 列

%    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000

%  97 列から 100 列

%    1.0000    1.0000    1.0000    1.0000