
function[matched]=my_siftmatch(dsc1,dsc2)

transposed_desc1=transpose(dsc1);
transposed_desc2=transpose(dsc2);

%desc1についての内容
n=size(transposed_desc1,1);
m=size(transposed_desc1,2);

%desc2についての内容
n2=size(transposed_desc2,1);

D2=repmat(transposed_desc2,n,1);%dsc2の転置行列の内容をn個(desc1の特徴点の数)だけ複製(n*n2)*m
D1=reshape((ones(n2,1)*reshape(transposed_desc1,1,m*n)),n*n2,m);%dsc1の内容がdesc2の特徴点の数だけ存在するように複製

dis_betD1D2=(D2-D1).^2;
D=sum(dis_betD1D2');
result=reshape(D,n2,n);

matched=[];

for i=1:n
  [M,idx]=min(result(:,i));%desc1の各特徴点に対してdesc2の中での最小距離のインデックスを求める.
  match=[i; idx];
  d=M*1.5;
  result(idx,i)=d;%計算した距離行列に1.5倍したもの
  if(d<=min(result(:,i)))%desc2の中に他に点が存在しない場合
    matched=[matched; match];%対応点のdesc1, desc2 の インデックス番号を表す縦ベクトルの集合として連結
  end
end

end