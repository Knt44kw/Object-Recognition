addpath('/usr/local/class/object/MATLAB/sift');
I1=im2double(rgb2gray(imread('wildcat.jpg')));
[pnt1,desc1]=sift(I1);
rotatedI1=imrotate(I1,45);%動物画像を45度回転
[pnt_r1,desc_r1]=sift(rotatedI1);

fig1=figure;
tic;
matchI1=siftmatch(desc1,desc_r1);
matchI1=matchI1(:,1:10);
fprintf('Rotated image matched in %.3f \n',toc);
colormap gray;
plotmatches(I1,rotatedI1,pnt1(1:2,:),pnt_r1(1:2,:),matchI1);

%同じ建物画像のペア
I2=im2double(rgb2gray(imread('himeji.jpg')));
[pnt2,desc2]=sift(I2);
fig2=figure;
tic;
matchI2=siftmatch(desc2,desc2);
matchI2=matchI2(:,1:10);
fprintf('The same image matched in %.3f \n',toc);
colormap gray;
plotmatches(I2,I2,pnt2(1:2,:),pnt2(1:2,:),matchI2);


%異なる建物画像のペア
I3=im2double(rgb2gray(imread('osaka.jpg')));
[pnt3,desc3]=sift(I3);

fig3=figure;
tic;
matchI3=siftmatch(desc2,desc3);
matchI3=matchI3(:,1:10);
fprintf('Different image matched in %.3f \n',toc);
colormap gray;
plotmatches(I2,I3,pnt2(1:2,:),pnt3(1:2,:),matchI3);

%コンソール上での実行結果
%Rotated image matched in 0.424 
%The same image matched in 0.037 
%Different image matched in 0.038 
