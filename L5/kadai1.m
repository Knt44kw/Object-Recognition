addpath('/usr/local/class/object/MATLAB/sift');
load('code_nnormal.mat','code_nnormal');
bof=transpose(code_nnormal);

D_pos=bof(1:100,:);
D_neg=bof(101:200,:);


pr_pos=sum(D_pos)+1;
pr_pos=pr_pos/sum(pr_pos);
pr_pos=log(pr_pos);

pr_neg=sum(D_neg)+1;
pr_neg=pr_neg/sum(pr_neg);
pr_neg=log(pr_neg);

%正答数と不正答数
correct=0;
incorrect=0;

%ポジティブ画像に対する分類
for j=1:100
 im=D_pos(j,:);
 max0=max(im);
 idx=[];
 for i=1:max0
   idx=[idx find(im>=i)];
 end
 
 pr_im_pos=sum(pr_pos(idx));
 pr_im_neg=sum(pr_neg(idx));
 
 if pr_im_neg < pr_im_pos
    correct=correct+1;
 else
     incorrect=incorrect+1;
 end

end

%ネガティブ画像に対する分類
for k=1:100
 im=D_neg(k,:);
 max0=max(im);
 idx=[ ];
 for l=1:max0
   idx=[idx find(im>=l)];
 end
 
 pr_im_pos=sum(pr_pos(idx));
 pr_im_neg=sum(pr_neg(idx));
 
 if pr_im_pos < pr_im_neg
    correct=correct+1;
 else
     incorrect=incorrect+1;
 end
 
end

correct_rate=correct/(correct+incorrect);

fprintf('Classification rate %.5f \n',correct_rate);
%{
Classification rate 0.85500 
%}