addpath('/usr/local/class/object/MATLAB/sift');
load('codebook_sift.mat','codebook');
load('code_sift.mat','code');

BoVW=transpose(code);

dist=squareform(pdist(BoVW(1:200,:)));

correct=0;
incorrect=0;

dist=dist + 10000*eye(size(dist));

for i=1:100
  [v idx1]=min(dist(i,:));
  if idx1<=100 
    correct=correct+1;
  else
    incorrect=incorrect+1;
  end
end

for i=101:200
  [v idx2]=min(dist(i,:));
  if idx2<=100 
    incorrect=incorrect+1;
  else
    correct=correct+1;
  end
end
 
fprintf('classification rate by sift: %.5f\n',correct/(correct+incorrect));


%{
classification rate by sift: 0.50000
%}
