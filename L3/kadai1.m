addpath('/usr/local/class/object/MATLAB/sift');
%動物画像
I1=im2double(rgb2gray(imread('wildcat.jpg')));
%webからとってきた画像
I2=im2double(rgb2gray(imread('trump.jpg')));
resizedI2=imresize(I2,[320 240]);

[pnt1,desc1]=sift(I1);
[pnt2,desc2]=sift(resizedI2);

fig1=figure;
imagesc(I1); colormap gray; hold on;
h1=plotsiftdescriptor(desc1(:,1:50),pnt1); set(h1,'linewidth',2,'color','b')
h1=plotsiftframe(pnt1(:,1:50));set(h1,'LineWidth',2,'Color','r');


fig2=figure;
figure(fig2)
imagesc(resizedI2); colormap gray; hold on;
h2=plotsiftdescriptor(desc2(:,1:50),pnt2) ; set(h2,'linewidth',2,'color','b')
h2=plotsiftframe(pnt2(:,1:50));set(h2,'LineWidth',2,'Color','g');
