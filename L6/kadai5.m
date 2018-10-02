addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
run('/usr/local/class/object/matconvnet/matlab/vl_setupnn');

src_img=im2single(rgb2gray(imread('last_supper.jpg')));
src_img2=im2single(rgb2gray(imread('toukaido.jpg')));
src_img3=im2single(rgb2gray(imread('guernica.jpg')));

src_img_lst={src_img,src_img2,src_img3};
%画像単独用
%goal=edge(src_img,'canny');

%画像複数用
goal_lst={edge(src_img,'canny'),edge(src_img2,'canny'),edge(src_img3,'canny')};

w=randn(3,3,1,1,'single');

tr=0.001;%ここを0.1,0.00001にセル配列を使って変える予定(コードの鮮やかさよりも提出優先の形で提出する)
         %なお複数の画像で行ったときは0.001にした.
epoch=10000;

%ここでは画像が複数の時の処理を記述している.
for i=1:epoch
  for j=1:length(src_img_lst)
  out_lst{j} = vl_nnconv(src_img_lst{j}, w, [],'pad',1) ;
  dzdy=out_lst{j}-goal_lst{j};
  [dzdx, dzdw] = vl_nnconv(src_img_lst{j}, w, [], dzdy, 'pad',1);
    w = w - tr * dzdw / (size(src_img_lst{j},1)*size(src_img_lst{j},2));
  if mod(i,50)==0
    loss_lst{j}=0.5*sum((out_lst{j}(:)-goal_lst{j}(:)).^2);
    fprintf('loss %d [%d] %f\n',j,i,loss_lst{j});
  end
  end
end

imwrite(goal_lst{1},'edge_04.jpg');
imwrite(out_lst{1} ,'out_04.jpg');

imwrite(goal_lst{2},'edge_05.jpg');
imwrite(out_lst{2} ,'out_05.jpg');

imwrite(goal_lst{3},'edge_06.jpg');
imwrite(out_lst{3} ,'out_06.jpg');

subplot(131),imshow(imread('last_supper.jpg'));
subplot(132),imshow(imread('edge_04.jpg'));
subplot(133),imshow(imread('out_04.jpg'));

figure;
subplot(131),imshow(imread('toukaido.jpg'));
subplot(132),imshow(imread('edge_05.jpg'));
subplot(133),imshow(imread('out_05.jpg'));

fig3=figure;
subplot(131),imshow(imread('guernica.jpg'));
subplot(132),imshow(imread('edge_06.jpg'));
subplot(133),imshow(imread('out_06.jpg'));

%{
3枚の画像の損出関数の値 loss1: 1番目の画像 loss2: 2番目の画像 loss3: 3番目の画像
loss 1 [50] 69640.523438
loss 2 [50] 658381.750000
loss 3 [50] 87092.617188
loss 1 [100] 40663.011719
loss 2 [100] 369637.625000
loss 3 [100] 48939.300781
loss 1 [150] 26337.480469
loss 2 [150] 221854.015625
loss 3 [150] 29615.505859
loss 1 [200] 19333.462891
loss 2 [200] 145923.484375
loss 3 [200] 19830.537109
loss 1 [250] 15965.416016
loss 2 [250] 106698.679688
loss 3 [250] 14876.469727
loss 1 [300] 14386.783203
loss 2 [300] 86281.164062
loss 3 [300] 12368.061523
loss 1 [350] 13676.936523
loss 2 [350] 75539.835938
loss 3 [350] 11096.981445
loss 1 [400] 13380.218750
loss 2 [400] 69805.140625
loss 3 [400] 10451.470703
loss 1 [450] 13273.502930
loss 2 [450] 66680.773438
loss 3 [450] 10121.920898
loss 1 [500] 13249.293945
loss 2 [500] 64930.839844
loss 3 [500] 9951.635742
loss 1 [550] 13257.062500
loss 2 [550] 63914.453125
loss 3 [550] 9861.520508
************************
loss 1 [9700] 12198.491211
loss 2 [9700] 52096.867188
loss 3 [9700] 8403.067383
loss 1 [9750] 12193.667969
loss 2 [9750] 52057.046875
loss 3 [9750] 8397.965820
loss 1 [9800] 12188.850586
loss 2 [9800] 52017.386719
loss 3 [9800] 8392.880859
loss 1 [9850] 12184.039062
loss 2 [9850] 51977.914062
loss 3 [9850] 8387.818359
loss 1 [9900] 12179.255859
loss 2 [9900] 51938.710938
loss 3 [9900] 8382.791016
loss 1 [9950] 12174.471680
loss 2 [9950] 51899.589844
loss 3 [9950] 8377.777344
loss 1 [10000] 12169.692383
loss 2 [10000] 51860.636719
loss 3 [10000] 8372.774414
%}

%以下1枚での画像の時
%{
imwrite(goal,'edge_02.jpg');
imwrite(out ,'out_02.jpg');
%}

%学習率0.1のとき
%{
imwrite(goal,'edge_01.jpg');
imwrite(out ,'out_01.jpg');

subplot(131),imshow(imread('last_supper.jpg'));
subplot(132),imshow(imread('edge_01.jpg'));
subplot(133),imshow(imread('out_01.jpg'));
%}
%学習率0.1の時の損出関数の値(抜粋)
%{
[50] 10997.784180
[100] 10737.776367
[150] 10513.652344
[200] 10319.888672
[250] 10151.820312
[300] 10005.550781
[350] 9877.798828
[400] 9765.801758
[450] 9667.234375
[500] 9580.141602
[550] 9502.875977
[600] 9434.034180
[650] 9372.452148
[700] 9317.125000
[750] 9267.211914
[800] 9221.993164
[850] 9180.870117
[900] 9143.316406
[950] 9108.897461
[1000] 9077.233398
    **********
[9400] 8422.803711
[9450] 8422.511719
[9500] 8422.219727
[9550] 8421.933594
[9600] 8421.655273
[9650] 8421.376953
[9700] 8421.107422
[9750] 8420.838867
[9800] 8420.576172
[9850] 8420.317383
[9900] 8420.064453
[9950] 8419.814453
[10000] 8419.567383
 %}

%学習率0.000001のとき
%{
imwrite(goal,'edge_02.jpg');
imwrite(out ,'out_02.jpg');

subplot(131),imshow(imread('last_supper.jpg'));
subplot(132),imshow(imread('edge_02.jpg'));
subplot(133),imshow(imread('out_02.jpg'));
%}
%学習率0.000001の時の損出関数の値(抜粋)
%{
[50] 126197.718750
[100] 126182.312500
[150] 126166.945312
[200] 126151.515625
[250] 126136.187500
[300] 126120.773438
[350] 126105.437500
[400] 126090.085938
[450] 126074.671875
[500] 126059.320312
[550] 126043.953125
[600] 126028.554688
[650] 126013.242188
[700] 125997.875000
[750] 125982.476562
[800] 125967.125000
[850] 125951.757812
[900] 125936.398438
[950] 125921.085938
[1000] 125905.671875
*******************
[9350] 123361.382812
[9400] 123346.289062
[9450] 123331.234375
[9500] 123316.164062
[9550] 123301.078125
[9600] 123286.046875
[9650] 123270.960938
[9700] 123255.859375
[9750] 123240.796875
[9800] 123225.742188
[9850] 123210.648438
[9900] 123195.593750
[9950] 123180.546875
[10000] 123165.484375
 %}
%学習率が低いほど負方向(誤差関数を最小化しようとする方向)へと進みにくくなっているので
%御座関数の評価値が大きくなり,なかなか小さくならないことがわかる.


%実行例のpdfは単独の時の結果(順に学習率0.1のとき,0.000001のとき)と
%複数枚の時の各画像の結果の順になっている.


