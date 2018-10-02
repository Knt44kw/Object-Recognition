nval='What is the value of n(Vertical): ';
n=input(nval);
mval='What is the value of m(Horizontal): ';
m=input(mval);

DB=rand(n,m);
test=rand(1,m);%�V���ɗ^������m�������x�N�g��
testdup=repmat(test,n,1);%�V���ɗ^�����鉡�x�N�g����n*m�ւƕ���

%for����p�����ꍇ
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

%�x�N�g������p�����ꍇ
tic
d2=(DB-testdup).^2;
D2=sqrt(sum(d2'));
[M,I]=min(D2(:));
disp(I);
toc

%���s�� m=128, n=100
%What is the value of n(Vertical): 100
%What is the value of m(Horizontal): 128
%    88

%�o�ߎ��Ԃ� 0.001608 �b�ł��B
%    88

%�o�ߎ��Ԃ� 0.000357 �b�ł��B

%���s�� m=128, n=1000

%What is the value of n(Vertical): 1000
%What is the value of m(Horizontal): 128
%   751

%�o�ߎ��Ԃ� 0.107730 �b�ł��B
%   751

%�o�ߎ��Ԃ� 0.001383 �b�ł��B


%���s�� m=128, n=10000

%What is the value of n(Vertical): 10000
%What is the value of m(Horizontal): 128
%        4705

%�o�ߎ��Ԃ� 4.757820 �b�ł��B
%        4705

%�o�ߎ��Ԃ� 0.048939 �b�ł��B
