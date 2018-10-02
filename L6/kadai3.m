addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');

vl_setupnn;

net = load('imagenet-caffe-alex.mat') ;


im = imread('junco.jpg');
resized_im=imresize(im,[224 224]);
im_ = single(resized_im) ; 
im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
im_ = im_ - net.meta.normalization.averageImage ;


res = vl_simplenn(net, im_);



% 最初の畳み込み層の出力の特徴マップ
figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(2).x),'spacing',2)

% 2番目の畳み込み層の出力の特徴マップ
figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(6).x),'spacing',2)

% 3番目の畳み込み層の出力の特徴マップ
figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(10).x),'spacing',2)

% 4番目の畳み込み層の出力の特徴マップ
figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(12).x),'spacing',2)

% 5番目の畳み込み層の出力の特徴マップ
figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(14).x),'spacing',2)

im2 = imread('scrpion.jpg');
resized_im2=imresize(im2,[224 224]);
im2_ = single(resized_im2) ; 
im2_ = imresize(im2_, net.meta.normalization.imageSize(1:2)) ;
im2_ = im2_ - net.meta.normalization.averageImage ;


res2 = vl_simplenn(net, im2_);
% 最初の畳み込み層の出力の特徴マップ
figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res2(2).x),'spacing',2)

% 2番目の畳み込み層の出力の特徴マップ
figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res2(6).x),'spacing',2)

% 3番目の畳み込み層の出力の特徴マップ
figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res2(10).x),'spacing',2)

% 4番目の畳み込み層の出力の特徴マップ
figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res2(12).x),'spacing',2)

% 5番目の畳み込み層の出力の特徴マップ
figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res2(14).x),'spacing',2)

