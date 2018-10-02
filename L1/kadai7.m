nval='What is the value of n(Vertical): ';
n=input(nval);
mval='What is the value of m(Horizontal): ';
m=input(mval);

DB=rand(n,m);
test=rand(1,m);%新たに与えられるm次元横ベクトル
testdup=repmat(test,n,1);%新たに与えられる横ベクトルをn*mへと複製

%for文を用いた場合
tic
for i=1:n
    for j=1:m
        d1(i,j)=( DB(i,j)-testdup(i,j) )^2;
    end
end
D1=sqrt(sum(d1'));
[M,I]=min(D1(:));
disp(I);
toc

%ベクトル化を用いた場合
tic
d2=(DB-testdup).^2;
D2=sqrt(sum(d2'));
[M,I]=min(D2(:));
disp(I);
toc

%実行例 m=128, n=100
%What is the value of n(Vertical): 100
%What is the value of m(Horizontal): 128
%    88

%経過時間は 0.001608 秒です。
%    88

%経過時間は 0.000357 秒です。

%実行例 m=128, n=1000

%What is the value of n(Vertical): 1000
%What is the value of m(Horizontal): 128
%   751

%経過時間は 0.107730 秒です。
%   751

%経過時間は 0.001383 秒です。


%実行例 m=128, n=10000

%What is the value of n(Vertical): 10000
%What is the value of m(Horizontal): 128
%        4705

%経過時間は 4.757820 秒です。
%        4705

%経過時間は 0.048939 秒です。
