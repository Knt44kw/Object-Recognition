addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');

vl_setupnn;

net = load('imagenet-caffe-alex.mat');

im = imread('cancer_magister.jpg');
resized_im=imresize(im,[224 224]);
im_ = single(resized_im) ; 
im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
im_ = im_ - net.meta.normalization.averageImage ;


res = vl_simplenn(net, im_);

[pr idx]=max(res(end).x);
dzdy=zeros(1,1,1000);
dzdy(1,1,idx)=1;
res = vl_simplenn(net, im_, dzdy);

out=abs(res(1).dzdx); % 入力画像のdE/dxの絶対値．
out=max(out,[],3);    % RGB のうちの最大値．
maxv=max(out(:));     % 最大値．  
out=out/maxv;         % 値の正規化．

subplot(121),imshow(im);%元画像
subplot(122),imshow(out);%クラス顕著性マップの表示

im2 = imread('partridge.jpg');
resized_im2=imresize(im2,[224 224]);
im2_ = single(resized_im2) ; 
im2_ = imresize(im2_, net.meta.normalization.imageSize(1:2)) ;
im2_ = im2_ - net.meta.normalization.averageImage ;


res2 = vl_simplenn(net, im2_);

[pr2 idx2]=max(res2(end).x);
dzdy=zeros(1,1,1000);
dzdy(1,1,idx2)=1;
res2 = vl_simplenn(net, im2_, dzdy);

out2=abs(res2(1).dzdx); % 入力画像のdE/dxの絶対値．
out2=max(out2,[],3);    % RGB のうちの最大値．
maxv2=max(out2(:));     % 最大値．  
out2=out2/maxv2;         % 値の正規化．

figure;
subplot(121),imshow(im2);%元画像
subplot(122),imshow(out2);%クラス顕著性マップの表示

%実行結果のpdfは元画像とそのクラス顕著性マップ

