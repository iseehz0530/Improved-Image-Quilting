function imgOut=imgSynth_quilt(ntilesout,tilesize,overlap,error,imgPath,alpha,imgFirst)

% warning off;
% close all;
% % imagefile1 = '7.jpg';
% % imagefile2 = '4.jpg';
% 
% ntilesout = [4 5];   
% 
% % ÿ��tile��ĳߴ�Ϊ200*200����
% tilesize = 200;
% overlap = 20;
% sampleI1=imread(randomPic);
% sampleI2=imread(randomPic);

global database_name;
global table_name;


% ������
imgOut=zeros((ntilesout(1)*tilesize-(ntilesout(1)-1)*overlap),(ntilesout(2)*tilesize-(ntilesout(2)-1)*overlap),1:3);
imgOut = uint8(imgOut);
% ������ж��ٸ�tile�����ߺͿ�

for i = 1:ntilesout(1)
    for j = 1:ntilesout(2)

        if (i==1)&(j==1)
             
            imgOut(1:tilesize,1:tilesize,1:3) = imgFirst;
            
        elseif(i==1)
%             ��һ�У��������ң���j=2��ʼ��
            x_startTile = tilesize*(j-2) - overlap*(j-2)+1;
            x_endTile = tilesize*(j-1) - overlap*(j-2);
            lefttile = imgOut(1:tilesize,x_startTile:x_endTile,1:3);
            
            [left_feature right_feature top_feature boom_feature] = picHog(lefttile,overlap,alpha);
            
%           ���ݵ�ǰͼƬ���Ҳ࣬ƥ����ͼƬ����࣬���ҵ�ͼƬ����
            imgName = picSearchByRight_feature(right_feature,error);
            rightTile = imread(strcat(imgPath,imgName));

            aaa=stitchLR(lefttile,rightTile,overlap,tilesize);

            bb=aaa(1:tilesize,end-tilesize+1:end,1:3);
            imgStich_start = tilesize*(j-1)-overlap*(j-1)+1;
            imgStich_end = tilesize*j-overlap*(j-1);
            imgOut(1:tilesize,imgStich_start:imgStich_end,1:3)=bb(:,:,1:3);
        elseif(j==1)
%             ��һ�У�����������i=2��ʼ
            y_startTile = tilesize*(i-2) - overlap*(i-2)+1;
            y_endTile = tilesize*(i-1) - overlap*(i-2);
            toptile = imgOut(y_startTile:y_endTile,1:tilesize,1:3);
            
            
            [left_feature right_feature top_feature boom_feature] = picHog(toptile,overlap,alpha);
            
%           ���ݵ�ǰͼƬ���·���ƥ����ͼƬ���Ϸ������ҵ�ͼƬ����
            imgName = picSearchByBoom_feature(boom_feature,error);
            boomtile = imread(strcat(imgPath,imgName));
            
            bbb = stitchTB(toptile,boomtile,overlap,tilesize);
            bb=bbb(end-tilesize+1:end,1:tilesize,1:3);

            imgStich_start = tilesize*(i-1)-overlap*(i-1)+1;
            imgStich_end = tilesize*i-overlap*(i-1);
            imgOut(imgStich_start:imgStich_end,1:tilesize,1:3)=bb;

            
        else
%             ���������У����� ���� �ص�����left��top��
%              
%             imshow(imgOut);
%             drawnow;
%             newPic = randomPic;

%           ѡ��lefttile����
            xL_startTile = tilesize*(j-2) - overlap*(j-2)+1;
            xL_endTile = tilesize*(j-1) - overlap*(j-2);
            yL_startTile = tilesize*(i-1) - overlap*(i-1)+1;
            yL_endTile = tilesize*i - overlap*(i-1);
            lefttile = imgOut(yL_startTile:yL_endTile,xL_startTile:xL_endTile,1:3);

%           ѡ��toptile
            xT_startTile = tilesize*(j-1) - overlap*(j-1)+1;
            xT_endTile = tilesize*j - overlap*(j-1);
            yT_startTile = tilesize*(i-2) - overlap*(i-2)+1;
            yT_endTile = tilesize*(i-1) - overlap*(i-2);
            
%             �˴���imgOutΪԭʼ��ģ���߻�δ���
            toptile = imgOut(yT_startTile:yT_endTile,xT_startTile:xT_endTile,1:3);
            
            [left_feature right_feature1 top_feature boom_feature] = picHog(lefttile,overlap,alpha);
            
            [left_feature right_feature top_feature boom_feature1] = picHog(toptile,overlap,alpha);
            
            
%           ���ݵ�ǰͼƬ���·���ƥ����ͼƬ���Ϸ������ҵ�ͼƬ����
            imgName = picSearchByRight_Boom_feature(right_feature1,boom_feature1,error);
            imgLeftBoom = imread(strcat(imgPath,imgName));

            result_LR=stitchLR(lefttile,imgLeftBoom,overlap,tilesize);
            result_LR_cut=result_LR(1:tilesize,end-tilesize+1:end,1:3);

            result_TB = stitchTB(toptile,imgLeftBoom,overlap,tilesize);
            
%             ����Ŀ�Χ��overlap+1:end������Ĩȥ������ϵ�����
            result_TB_cut=result_TB(end-tilesize+1:end,overlap+1:end,1:3);

            stichX_LR_start = tilesize*(j-1)-overlap*(j-1)+1;
            stichX_LR_end = tilesize*j-overlap*(j-1);
            
            stichY_LR_start = tilesize*(i-1)-overlap*(i-1)+1;
            stichY_LR_end = tilesize*i-overlap*(i-1);
            
            imgOut(stichY_LR_start:stichY_LR_end,stichX_LR_start:stichX_LR_end,1:3)=result_LR_cut;
            
            stichX_TB_start = tilesize*(j-1)-overlap*(j-2)+1;
            stichX_TB_end = tilesize*j-overlap*(j-1);
            stichY_TB_start = tilesize*(i-1)-overlap*(i-1)+1;
            stichY_TB_end = tilesize*i-overlap*(i-1);
            
            imgOut(stichY_TB_start:stichY_TB_end,stichX_TB_start:stichX_TB_end,1:3)=result_TB_cut;

        end
%         imshow(imgOut);
%         drawnow;

    end
end

end
