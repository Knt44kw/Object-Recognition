nval='What is the value of n(Vertical): ';
n=input(nval);
mval='What is the value of m(Horizontal): ';
m=input(mval);

DB=rand(n,m);
test=rand(1,m);%新たに与えられるm次元横ベクトル
testdup=repmat(test,n,1);%新たに与えられる横ベクトルをn*mへと複製
dis=zeros(n,m);%データベースと新たな横ベクトルとの距離を格納する配列


for i=1:n
    for j=1:m
        dis(i,j)=( DB(i,j)-testdup(i,j) )^2;
    end
end
 D=sqrt(sum(dis'));
 disp(D);
[M,I]=min(D(:))%実行例で出てくるIの値が類似度が最も高いインデックス番号になる

%実行例
% What is the value of n(Vertical): 10
% What is the value of m(Horizontal): 7
%  1 列から 7 列

%    1.1932    0.7772    1.1789    1.0965    0.9472    0.7958    1.4050

%  8 列から 10 列

%    1.0889    1.2492    0.8055

%M =

%    0.7772


%I =

%    2