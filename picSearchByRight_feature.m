function imgName = picSearchByRight_feature(right_feature,error)

global database_name;
global table_name;

jdbcUrl = strcat('jdbc:mysql://127.0.0.1:3306/',database_name);
conn=database(database_name,'root','123456','com.mysql.jdbc.Driver',jdbcUrl);

feature_name = 'right_feature';

sqlStatement = ['select',' ',feature_name,' ',' from ',' ',table_name];
curs_left = exec(conn,sqlStatement);

curs_left = fetch(curs_left);
% cur =cell2mat(curs)
name = curs_left.Data;
% ��ȡ�����ݺ󣬹ر�curs
close(curs_left)

% ��cell��������ת��Ϊdouble������
data = cell2mat(name);
cc = abs(data - right_feature);
% ���ҳ�ͼƬID
picId = find(cc<error);

if length(picId)==0
    picId = find(cc==min(cc));
end

% �����ݿ��ѯͼƬ
imgIndex=round(rand*(length(picId)-1)+1);
imgId = picId(imgIndex);

imgQueryText = ['select imgName from',' ',table_name,' ','where picId ='];

sql = strcat(imgQueryText,num2str(imgId));
curs = exec(conn,sql);
curs = fetch(curs);
imgId = curs.Data;
imgName = imgId{1};
    
close(conn)

end