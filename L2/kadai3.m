I=imread('Balaenicepsrex.jpg');
I2=rgb2gray(I);

subplot(2,2,1),imshow(I);
subplot(2,2,2),imshow(I2);

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

%64色に減色
X64=floor(double(R)/64) *4*4 + floor(double(G)/64) *4 + floor(double(B)/64);
%imagescを使った場合
subplot(2,2,3),imagesc(X64); 
colormap gray;
%imshowを使った場合
subplot(2,2,4),imshow(X64*4);

