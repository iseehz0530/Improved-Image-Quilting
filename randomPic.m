function image=randomPic(imgPath)

filePath = strcat(imgPath,'*.jpg');

% filename=dir('G:\图片生成\图片分割\三维 - 暗色\*.jpg');%存储所有文件名

filename = dir(filePath);
imgIndex=round(rand*(length(filename)-1)+1);
imageFile=strcat('F:\imageSet\pic_cut\pic1_cut\',filename(imgIndex).name);%存储路径

% imageFile = '1.jpg';
image = imread(imageFile);
% image = imresize(image,0.5);
end