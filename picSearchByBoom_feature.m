function imgName = picSearchByBoom_feature(boom_feature,error)

% conn=database('imgmarket','root','123456','com.mysql.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/imgmarket');
% 
% curs = exec(conn,'select boom_feature from pic2');
% 
% curs = fetch(curs);
% % cur =cell2mat(curs)
% name = curs.Data;
% % 提取出数据后，关闭curs
% close(curs)

global database_name;
global table_name;

jdbcUrl = strcat('jdbc:mysql://127.0.0.1:3306/',database_name);
conn=database(database_name,'root','123456','com.mysql.jdbc.Driver',jdbcUrl);

feature_name = 'boom_feature';
name = sqlQuery(feature_name);

% 将cell类型数据转换为double型数据
data = cell2mat(name);
cc = abs(data - boom_feature);
% 查找出图片ID
picId = find(cc<error);

if length(picId)==0
    picId = find(cc==min(cc));
end

% 回数据库查询图片
imgIndex=round(rand*(length(picId)-1)+1);
imgId = picId(imgIndex);

imgQueryText = ['select imgName from',' ',table_name,' ','where picId ='];
% imgQueryText = ['select imgName from',table_name,'where picId ='];

sql = strcat(imgQueryText,num2str(imgId));
curs = exec(conn,sql);
curs = fetch(curs);
imgId = curs.Data;
imgName = imgId{1};

close(conn)    

end