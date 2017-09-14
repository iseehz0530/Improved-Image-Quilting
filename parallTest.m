function parallTest
% matlabpool open local 2
% j=zeros(100,1); 
% parfor i=1:100;
% 	j(i,1)=5*i
% end;
matlabpool(4)
spmd
	j=zeros(1e7,1)
end;

matlabpool close  
end