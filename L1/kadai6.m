nval='What is the value of n(Vertical): ';
n=input(nval);
mval='What is the value of m(Horizontal): ';
m=input(mval);

DB=rand(n,m);
test=rand(1,m);%�V���ɗ^������m�������x�N�g��
testdup=repmat(test,n,1);%�V���ɗ^�����鉡�x�N�g����n*m�ւƕ���
dis=zeros(n,m);%�f�[�^�x�[�X�ƐV���ȉ��x�N�g���Ƃ̋������i�[����z��


for i=1:n
    for j=1:m
        dis(i,j)=( DB(i,j)-testdup(i,j) )^2;
    end
end
 D=sqrt(sum(dis'));
 disp(D);
[M,I]=min(D(:))%���s��ŏo�Ă���I�̒l���ގ��x���ł������C���f�b�N�X�ԍ��ɂȂ�

%���s��
% What is the value of n(Vertical): 10
% What is the value of m(Horizontal): 7
%  1 �񂩂� 7 ��

%    1.1932    0.7772    1.1789    1.0965    0.9472    0.7958    1.4050

%  8 �񂩂� 10 ��

%    1.0889    1.2492    0.8055

%M =

%    0.7772


%I =

%    2