%似ている画像のペア
I1=imread('kadai6-1.jpg');
I2=imread('kadai6-2.jpg');
%全く似ていない画像のペア用の画像
I3=imread('kadai6-4.jpg');


%画像I1のR,G,B
RI1=I1(:,:,1);
GI1=I1(:,:,2);
BI1=I1(:,:,3);

%画像I2のR.G.B
RI2=I1(:,:,1);
GI2=I1(:,:,2);
BI2=I1(:,:,3);

%画像I3のR.G.B
RI3=I1(:,:,1);
GI3=I1(:,:,2);
BI3=I1(:,:,3);

%それぞれの画像のRGBを64色に減色
X64img1=floor(double(RI1)/64) *4*4 + floor(double(GI1)/64) *4 + floor(double(BI1)/64);
X64img2=floor(double(RI2)/64) *4*4 + floor(double(GI2)/64) *4 + floor(double(BI2)/64);
X64img3=floor(double(RI3)/64) *4*4 + floor(double(GI3)/64) *4 + floor(double(BI3)/64);

subplot(131),histogram(X64img1);
subplot(132),histogram(X64img2);
subplot(133),histogram(X64img3);

X64img1_reshape=reshape(X64img1,1,numel(X64img1));
X64img2_reshape=reshape(X64img2,1,numel(X64img2));
X64img3_reshape=reshape(X64img3,1,numel(X64img3));

%ヒストグラムの作成
h1=histc(X64img1_reshape, [0:63]);
h2=histc(X64img2_reshape, [0:63]);
h3=histc(X64img3_reshape, [0:63]);

%要素の合計が1になるように正規化する.
h1=h1/sum(h1);
h2=h2/sum(h2);
h3=h3/sum(h3);

%似ている画像のペアの類似度の計算
test1=sum( min(h1,h2) )

%全く異なる画像のペアの類似度の計算
test2=sum( min(h1,h3) )

%実行例

%test1 =

%  


%test2 =

%    1.0000
