

I=rgb2gray(imread('Balaenicepsrex.jpg'));
ISmooth5=I;%平滑化フィルタリングで5回適用したものを格納するため
ISmooth10=I;%平滑化フィルタリングで10回適用したものを格納するため

f=[1 1 1; 1 1 1; 1 1 1]/9;
f2=[1 1 1; 1 -8 1; 1 1 1];%ラプラシアンフィルタ
f3=[-1 -2 -1; 0 0 0; 1 2 1];%Sobelフィルタ垂直方向のマスク
f4=[-1 0 1; -2 0 2; -1 0 1];%Sobelフィルタ水平方向のマスク
f5=[1 2 1; 2 4 2; 1 2 1]/16; %ガウシアンフィルタ

subplot(331),imshow(I);%元画像

ISmooth=uint8(filter2(f,I,'same'));
subplot(332),imshow(ISmooth);%1回適用


for i=1:5
   ISmooth5=uint8(filter2(f,ISmooth5,'same')); 
end

for i=1:10
 ISmooth10=uint8(filter2(f,ISmooth10,'same'));
end

subplot(333),imshow(ISmooth5);%5回適用
subplot(334),imshow(ISmooth10);%10回適用

%ラプラシアンフィルタ
ILap=uint8(abs(filter2(f2,I,'same')));
subplot(335),imshow(ILap);

ISobV=uint8(abs(filter2(f3,I,'same')));
ISobH=uint8(abs(filter2(f4,I,'same')));
subplot(336),imshow(ISobV);%垂直方向のエッジ抽出
subplot(337),imshow(ISobH);%水平方向のエッジ抽出

sobelV=abs(filter2(f3,I,'same'));
sobelH=abs(filter2(f4,I,'same'));

%ソーベルフィルタ統合後
ISobresult=uint8(hypot(sobelV,sobelH));
subplot(338),imshow(ISobresult);

%ガウシアンフィルタ
IGauss=uint8(filter2(f5,I,'same'));
subplot(339),imshow(IGauss);

%実行例
%1行目は左から順に
%元画像,平滑化1回,平滑化5回
%2行目は左から順に
%平滑化10回,ラプラシアンフィルタ,ソーベルフィルタ縦のエッジ抽出
%3行目は左から順に
%ソーベルフィルタ横のエッジ抽出,ソーベルフィルタ統合後,ガウシアンフィルタ
%の順で表示している.