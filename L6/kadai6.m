addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
run('/usr/local/class/object/matconvnet/matlab/vl_setupnn');

src_img=im2single(rgb2gray(imread('last_supper.jpg')));
goal=edge(src_img,'canny');
w=randn(3,3,1,1,'single');
w1=randn(3,3,1,20,'single');
w2=randn(1,1,20,1,'single');

tr=0.001;
epoch=10000;

%1層の時
for i=1:epoch
  out = vl_nnconv(src_img, w, [],'pad',1);
  dzdy=out-goal;
  [dzdx, dzdw] = vl_nnconv(src_img, w, [], dzdy, 'pad',1) ;
  w = w - tr * dzdw / (size(src_img,1)*size(src_img,2));
  if mod(i,50)==0
    loss=0.5*sum((out(:)-goal(:)).^2);
    fprintf('Single layer [%d] %f\n',i,loss);
  end
end

imwrite(out ,'out_1_layer.jpg');

%ReLUなしの2層の時
for i=1:epoch
  x2 = vl_nnconv(src_img, w1, [],'pad',1);
  out2=vl_nnconv(x2,w2,[]);
  
  dzdy=out2-goal;
  [dzdx, dzdw] = vl_nnconv(x2, w2, [], dzdy);
  w2 = w2 - tr * dzdw / (size(x2,1)*size(x2,2));
  
  [dzdx, dzdw] = vl_nnconv(src_img, w1 , [], dzdx, 'pad',1) ;
  w1 = w1 - tr * dzdw / (size(src_img,1)*size(src_img,2));
  
  if mod(i,50)==0
    loss=0.5*sum((out2(:)-goal(:)).^2);
    fprintf('Two Layers without ReLU [%d] %f\n',i,loss);
  end
end

imwrite(out2,'out_nReLU.jpg');

%ReLUありの2層の時
for i=1:epoch
  x2 = vl_nnconv(src_img, w1, [],'pad',1);
  x3=vl_nnrelu(x2);
  out3 = vl_nnconv(x3, w2, []);
  dzdy=out-goal;
  
  [dzdx, dzdw] = vl_nnconv(x3, w2, [], dzdy) ;
  w2 = w2 - tr * dzdw / (size(x2,1) * size(x2,2));
  dzdx = vl_nnrelu(x2,dzdx);
  [dzdx, dzdw] = vl_nnconv(src_img, w1, [], dzdx, 'pad',1);
  w1 = w1 - tr * dzdw / (size(src_img,1)*size(src_img,2));
   if mod(i,50)==0 
    loss=0.5*sum((out3(:)-goal(:)).^2);
    fprintf('Two Layers with ReLU [%d] %f\n',i,loss);
  end
end

imwrite(out3 ,'out_ReLU.jpg');

subplot(131),imshow('out_1_layer.jpg');
subplot(132),imshow('out_nReLU.jpg');
subplot(133),imshow('out_ReLU.jpg');

%実行結果のpdfは左から1層,ReLUなしの2層,ReLUありの2層の実行結果
%実行例の一例として最後の晩餐の時の損失関数の結果を示す.
%{
1層
Single layer [50] 103169.421875
Single layer [100] 91816.250000
Single layer [150] 81881.625000
Single layer [200] 73188.156250
Single layer [250] 65580.867188
Single layer [300] 58923.890625
Single layer [350] 53098.476562
Single layer [400] 48000.605469
Single layer [450] 43539.394531
Single layer [500] 39635.253906
Single layer [550] 36218.554688
Single layer [600] 33228.316406
Single layer [650] 30611.285156
*******************************
Single layer [9200] 11595.027344
Single layer [9250] 11591.263672
Single layer [9300] 11587.505859
Single layer [9350] 11583.752930
Single layer [9400] 11580.003906
Single layer [9450] 11576.258789
Single layer [9500] 11572.526367
Single layer [9550] 11568.790039
Single layer [9600] 11565.064453
Single layer [9650] 11561.348633
Single layer [9700] 11557.641602
Single layer [9750] 11553.936523
Single layer [9800] 11550.233398
Single layer [9850] 11546.535156
Single layer [9900] 11542.846680
Single layer [9950] 11539.157227
Single layer [10000] 11535.483398

ReLUなしの2層
Two Layers without ReLU [50] 52747.722656
Two Layers without ReLU [100] 37525.777344
Two Layers without ReLU [150] 36730.003906
Two Layers without ReLU [200] 35999.273438
Two Layers without ReLU [250] 35295.316406
Two Layers without ReLU [300] 34616.777344
Two Layers without ReLU [350] 33962.566406
Two Layers without ReLU [400] 33331.636719
Two Layers without ReLU [450] 32722.941406
Two Layers without ReLU [500] 32135.542969
Two Layers without ReLU [550] 31568.544922
Two Layers without ReLU [600] 31021.066406
Two Layers without ReLU [650] 30492.275391
Two Layers without ReLU [700] 29981.431641
Two Layers without ReLU [750] 29487.732422
Two Layers without ReLU [800] 29010.537109
******************************************
Two Layers without ReLU [9100] 11408.270508
Two Layers without ReLU [9150] 11388.415039
Two Layers without ReLU [9200] 11368.740234
Two Layers without ReLU [9250] 11349.245117
Two Layers without ReLU [9300] 11329.919922
Two Layers without ReLU [9350] 11310.763672
Two Layers without ReLU [9400] 11291.783203
Two Layers without ReLU [9450] 11272.972656
Two Layers without ReLU [9500] 11254.325195
Two Layers without ReLU [9550] 11235.833008
Two Layers without ReLU [9600] 11217.507812
Two Layers without ReLU [9650] 11199.338867
Two Layers without ReLU [9700] 11181.333984
Two Layers without ReLU [9750] 11163.486328
Two Layers without ReLU [9800] 11145.786133
Two Layers without ReLU [9850] 11128.237305
Two Layers without ReLU [9900] 11110.837891
Two Layers without ReLU [9950] 11093.569336
Two Layers without ReLU [10000] 11076.452148


ReLUありの2層
Two Layers with ReLU [50] 44664.957031
Two Layers with ReLU [100] 44284.410156
Two Layers with ReLU [150] 43902.261719
Two Layers with ReLU [200] 43519.769531
Two Layers with ReLU [250] 43137.675781
Two Layers with ReLU [300] 42755.929688
Two Layers with ReLU [350] 42373.144531
Two Layers with ReLU [400] 41988.894531
Two Layers with ReLU [450] 41605.562500
Two Layers with ReLU [500] 41223.648438
Two Layers with ReLU [550] 40841.808594
Two Layers with ReLU [600] 40460.761719
Two Layers with ReLU [650] 40079.820312
Two Layers with ReLU [700] 39699.886719
Two Layers with ReLU [750] 39321.175781
Two Layers with ReLU [800] 38943.457031
***************************************
Two Layers with ReLU [9200] 136213.375000
Two Layers with ReLU [9250] 137335.312500
Two Layers with ReLU [9300] 138456.812500
Two Layers with ReLU [9350] 139577.750000
Two Layers with ReLU [9400] 140701.218750
Two Layers with ReLU [9450] 141824.000000
Two Layers with ReLU [9500] 142945.906250
Two Layers with ReLU [9550] 144069.328125
Two Layers with ReLU [9600] 145194.562500
Two Layers with ReLU [9650] 146319.546875
Two Layers with ReLU [9700] 147445.265625
Two Layers with ReLU [9750] 148575.218750
Two Layers with ReLU [9800] 149709.625000
Two Layers with ReLU [9850] 150844.109375
Two Layers with ReLU [9900] 151982.109375
Two Layers with ReLU [9950] 153121.500000
Two Layers with ReLU [10000] 154261.203125
%}