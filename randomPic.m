function image=randomPic(imgPath)

filePath = strcat(imgPath,'*.jpg');

% filename=dir('G:\ͼƬ����\ͼƬ�ָ�\��ά - ��ɫ\*.jpg');%�洢�����ļ���

filename = dir(filePath);
imgIndex=round(rand*(length(filename)-1)+1);
imageFile=strcat('F:\imageSet\pic_cut\pic1_cut\',filename(imgIndex).name);%�洢·��

% imageFile = '1.jpg';
image = imread(imageFile);
% image = imresize(image,0.5);
end