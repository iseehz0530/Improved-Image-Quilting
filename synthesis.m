function testAll
% matlabpool open local 2
% parpool(4)

warning off;
% ��������

% RGBռ�ȣ��ݶ�ռ�� = 1-alpha
alpha = 0.6;
imgPath = 'F:\imageSet\pic_cut\pic1_cut\';


% �������ݿ�
global database_name;
global table_name;
database_name = 'imgmarket';
% table_name = 'pic1';

% �����������
error = 2.5e+4;
% ����ߴ磬��tile��������
ntilesout = [10 10];

img_out_maindir = 'F:\imageSet\pic_syn_out';
img_out_subdir =  dir( img_out_maindir );

img_in_maindir = 'F:\imageSet\pic_cut';
img_in_subdir =  dir( img_in_maindir );   % ��ȷ�����ļ���

for j = 10 : length( img_in_subdir )
    img_in_subdir_name = img_in_subdir(j).name;
    img_in_Path = strcat(img_in_maindir,'\',img_in_subdir_name);
    img_in_names=dir(strcat(img_in_Path,'\*.jpg'));
    
    %     ���ݱ������ļ�������һһ��Ӧ
    table_name = img_in_subdir_name;
    table_name(end-3:end) = [];%ȥ�� _cut
    
%     ����ļ���
    img_out_subdir_name = img_out_subdir(j).name;
    img_out_Path = strcat(img_out_maindir,'\',img_out_subdir_name,'\');
    
%     matlabpool(2)
%     spmd
    for i=546:length(img_in_names)
        tic
%         ����ҳ�һ��ͼƬ����ΪimgFirst
        imgIndex = round(rand*(length(img_in_names)-1)+1);
        if imgIndex <3
            imgIndex = imgIndex + round(rand*(30)+1);
        end
        filename = dir(img_in_Path);
        imgFirst = strcat(img_in_Path,'\',filename(imgIndex).name);%�洢·��
        imgFirst = imread(imgFirst);
%         ����tilesize��overlap
        [height,width,k] = size(imgFirst);
        tilesize = height;
        overlap = ceil(height/6);
        
        img_in_Path1 = strcat(img_in_Path,'\');
        
%         ����ͼƬ
        imgOut=imgSynth_quilt(ntilesout,tilesize,overlap,error,img_in_Path1,alpha,imgFirst);
        img_name = strcat(img_out_Path,table_name,'_',int2str(i),'.jpg');
        imwrite(imgOut,img_name);
        jj = j
        ii = i
        toc
        time = toc
    end
%     end
%     matlabpool close 
end


end







 
% imgOut=imgSynth_quilt(ntilesout,tilesize,overlap,error,imgPath,alpha,imgFirst);

% end