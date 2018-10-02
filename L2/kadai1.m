addpath('/usr/local/class/object/MATLAB/sift');
I=rgb2gray(imread('Balaenicepsrex.jpg'));

tightsubplot(2,3,1),imshow(I);

sobel_edge=edge(I,'Sobel');
tightsubplot(2,3,2),imshow(sobel_edge);

prewitt_edge=edge(I,'Prewitt');
tightsubplot(2,3,3),imshow(prewitt_edge);

roberts_edge=edge(I,'Roberts');
tightsubplot(2,3,4),imshow(roberts_edge);

log_edge=edge(I,'log');
tightsubplot(2,3,5),imshow(log_edge);

canny_edge=edge(I,'Canny');
tightsubplot(2,3,6),imshow(canny_edge);

%pdfとしてあげた画像は
%1行目は左から,元画像,Sobelフィルタ,Prewittフィルタを適用したもの
%2行めは左からRobertsフィルタ,logフィルタ, Canny法によるエッジ検出を適用した結果.
%を表している.
