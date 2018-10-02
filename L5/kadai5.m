addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');


vl_setupnn;


net = load('imagenet-caffe-alex.mat') ;

%1000クラス画像
img_lst={'great_gray_owl.jpg','green_lizard.jpg','indigo_bunting.jpg','lakeland_terrier.jpg','ruffed_grouse.jpg'};
for i=1:5
im = imread(img_lst{i});
im_ = single(im) ; 
im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
im_ = im_ - net.meta.normalization.averageImage ;
res = vl_simplenn(net, im_);

scores = squeeze(res(end).x);  
[sorted_scores idx] = sort(scores,'descend'); 

for j=1:5 
  fprintf('[%d] (class id:%d) (score: %.5f) %s\n',j,idx(j), ...
  sorted_scores(j), net.meta.classes.description{idx(j)});
end
end

%1000クラス画像ではない画像

img_lst2={'karaage.jpg','teriyaki.jpg','yakitori.jpg'};
for k=1:3
im2 = imread(img_lst2{k});
im2_ = single(im2) ; 
im2_ = imresize(im2_, net.meta.normalization.imageSize(1:2)) ;
im2_ = im2_ - net.meta.normalization.averageImage ;
res2 = vl_simplenn(net, im2_);

scores2 = squeeze(res2(end).x);  
[sorted_scores2 idx2] = sort(scores2,'descend'); 

for l=1:5 
  fprintf('[%d] (class id:%d) (score: %.5f) %s\n',l,idx2(l), ...
  sorted_scores2(l), net.meta.classes.description{idx2(l)});
end
end

%1000クラス画像ではない画像の表示
for m=1:length(img_lst2)
subplot(1,3,m),imshow(img_lst2{m});
end

%{
1000クラス画像の時
[1] (class id:25) (score: 1.00000) great grey owl, great gray owl, Strix nebulosa
[2] (class id:83) (score: 0.00000) ruffed grouse, partridge, Bonasa umbellus
[3] (class id:288) (score: 0.00000) lynx, catamount
[4] (class id:290) (score: 0.00000) snow leopard, ounce, Panthera uncia
[5] (class id:289) (score: 0.00000) leopard, Panthera pardus

[1] (class id:41) (score: 0.81284) American chameleon, anole, Anolis carolinensis
[2] (class id:47) (score: 0.18289) green lizard, Lacerta viridis
[3] (class id:43) (score: 0.00257) agama
[4] (class id:45) (score: 0.00054) alligator lizard
[5] (class id:39) (score: 0.00043) banded gecko

[1] (class id:15) (score: 0.99998) indigo bunting, indigo finch, indigo bird, Passerina cyanea
[2] (class id:137) (score: 0.00001) European gallinule, Porphyrio porphyrio
[3] (class id:18) (score: 0.00000) jay
[4] (class id:19) (score: 0.00000) magpie
[5] (class id:132) (score: 0.00000) little blue heron, Egretta caerulea

[1] (class id:190) (score: 0.93937) Lakeland terrier
[2] (class id:189) (score: 0.02243) wire-haired fox terrier
[3] (class id:192) (score: 0.01513) Airedale, Airedale terrier
[4] (class id:203) (score: 0.01295) soft-coated wheaten terrier
[5] (class id:176) (score: 0.00424) otterhound, otter hound

[1] (class id:83) (score: 0.99658) ruffed grouse, partridge, Bonasa umbellus
[2] (class id:87) (score: 0.00255) partridge
[3] (class id:84) (score: 0.00061) prairie chicken, prairie grouse, prairie fowl
[4] (class id:81) (score: 0.00012) black grouse
[5] (class id:82) (score: 0.00004) ptarmigan

%}

%{
1000クラス画像ではない画像の時
[1] (class id:936) (score: 0.50508) mashed potato
[2] (class id:963) (score: 0.33476) meat loaf, meatloaf
[3] (class id:929) (score: 0.06788) ice cream, icecream
[4] (class id:924) (score: 0.04362) plate
[5] (class id:961) (score: 0.02469) chocolate sauce, chocolate syrup

[1] (class id:963) (score: 0.26024) meat loaf, meatloaf
[2] (class id:965) (score: 0.20234) potpie
[3] (class id:931) (score: 0.17239) French loaf
[4] (class id:966) (score: 0.05032) burrito
[5] (class id:119) (score: 0.04724) Dungeness crab, Cancer magister

[1] (class id:122) (score: 0.13625) king crab, Alaska crab, Alaskan king crab, Alaska king crab, Paralithodes camtschatica
[2] (class id:964) (score: 0.09266) pizza, pizza pie
[3] (class id:927) (score: 0.07120) hot pot, hotpot
[4] (class id:583) (score: 0.06373) grocery store, grocery, food market, market
[5] (class id:910) (score: 0.05685) wok

%}
