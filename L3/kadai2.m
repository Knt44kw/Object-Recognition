addpath('/usr/local/class/object/MATLAB/sift');
%ライオン画像
I1=im2double(rgb2gray(imread('lion.jpg')));
lst=[];
thrshld=[0:0.01:0.1];
for i=1:size(thrshld,2)
   [pnt1,desc1]=sift(I1,'threshold',thrshld(i)); 
   lst=[lst size(pnt1,2)];
end
plot(thrshld,lst);
xlabel('Threshold');
ylabel('Number of SIFT features');
