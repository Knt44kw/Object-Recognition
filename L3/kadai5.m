addpath('/usr/local/class/object/MATLAB/sift');
imglist={'estima1.jpg','estima2.jpg','estima3.jpg','prius1.jpg','prius2.jpg','prius3.jpg','land1.jpg','land2.jpg','land3.jpg'};

[m,n]=size(imglist);
similarity=zeros(n,n);

for i=1:n
    I1=im2double(rgb2gray(imread(imglist{i})));
    [pnt1,desc1]=sift(I1);
    siftpnts1=size(pnt1,2);
    for j=1:n
      I2=im2double(rgb2gray(imread(imglist{j})));
      [pnt2,desc2]=sift(I2);
      siftpnts2=size(pnt2,2);
      match_betI1I2=siftmatch(desc1,desc2);
      [temp,corrpnts]=size(match_betI1I2);
      similarity(i,j)=corrpnts/((siftpnts1+siftpnts2)/2);
    end
end
disp(similarity);

%実行例
    

   % 1.0000    0.1221    0.0386    0.0622    0.0994    0.0483    0.0478    0.0758    0.0603
   % 0.0707    1.0000    0.0361    0.0434    0.1289    0.0432    0.0574    0.0696    0.0612
   % 0.0257    0.0506    1.0000    0.0298    0.0705    0.0339    0.0214    0.0398    0.0487   
   % 0.0432    0.0677    0.0291    1.0000    0.0883    0.0404    0.0395    0.0612    0.0488
   % 0.0346    0.0536    0.0164    0.0194    1.0000    0.0461    0.0271    0.0478    0.0286
   % 0.0248    0.0639    0.0345    0.0481    0.0931    1.0000    0.0351    0.0446    0.0395
   % 0.0314    0.0534    0.0257    0.0371    0.0649    0.0330    1.0000    0.0526    0.0470
   % 0.0723    0.0828    0.0522    0.0725    0.1822    0.0525    0.0628    1.0000    0.0659
   % 0.0432    0.0623    0.0322    0.0576    0.1265    0.0358    0.0601    0.0556    1.0000
    
    


    
    