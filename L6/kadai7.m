addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
vl_setupnn;


net = load('imagenet-caffe-alex.mat');

im = imread('mont_saint.jpg');
resized_im=imresize(im,[224 224]);%ここを224*224 320*240に変換
imsize=size(resized_im);
avg = imresize(net.meta.normalization.averageImage,imsize(1:2));
im_ = single(resized_im);
im_ = im_ - avg;


net.layers(16:21)=[];

lr=0.01;  % learning rate 学習率
ite=1000; % iteration number 繰り返し回数

for i=1:ite
  if mod(i,25)==0  
    fprintf('%d %f\n',i,max(reshape(res(1).dzdx,1,numel(res(1).dzdx)))*lr);
    out = uint8(im_ + avg);
    clf;
    imshow(out); % 画像出力
  end
  res = vl_simplenn(net, im_);
  dzdy = res(end).x ;
  res = vl_simplenn(net, im_, dzdy);
  im_ = im_ + lr * res(1).dzdx;
end
out = uint8(im_ + avg);
imwrite(out,'out3.jpg');

%実行結果のpdfはの富嶽三十六景とモンサンミッシェルの画像は224*224,320*240の順になっている
%画像サイズがあまりに大きい(1280*960とか)だとそもそも実行にかなりの時間を要したり
%エラーを吐かれることがあった.
%結果から画像サイズが小さいと(今回比較的小さめであるが)deepdreamの影響がより鮮明になっている.
%これから画像サイズが小さいほど特徴抽出が正確に行われているからこそ,歪みが強くなっているのではないかと
%考える.