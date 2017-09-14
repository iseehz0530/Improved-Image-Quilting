function imgName = picSearchByRight_Boom_feature(right_feature,boom_feature,error)

% conn=database('imgmarket','root','123456','com.mysql.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/imgmarket');

global database_name;
global table_name;

% 这里的error乘以一个扩大系数，增大搜索范围
error = error * 4;

jdbcUrl = strcat('jdbc:mysql://127.0.0.1:3306/',database_name);
conn=database(database_name,'root','123456','com.mysql.jdbc.Driver',jdbcUrl);

% 先根据右侧特征，找出符合要求的图片ID
feature_right_name = 'right_feature';
sqlStatement = ['select',' ',feature_right_name,' ',' from ',' ',table_name];
curs_right = exec(conn,sqlStatement);

curs_right = fetch(curs_right);
name = curs_right.Data;
% 提取出数据后，关闭curs
close(curs_right);

% 将cell类型数据转换为double型数据
data = cell2mat(name);
cc = abs(data - right_feature);
% 查找出图片ID
picId_right = find(cc<error);

if length(picId_right)==0
    picId_right = find(cc==min(cc));
end


% 再根据下方特征，找出符合要求的图片ID
feature_boom_name = 'right_feature';
sqlStatement = ['select',' ',feature_boom_name,' ',' from ',' ',table_name];
curs_boom = exec(conn,sqlStatement);

curs_boom = fetch(curs_boom);
name = curs_boom.Data;
% 提取出数据后，关闭curs
close(curs_boom)

% 将cell类型数据转换为double型数据
data = cell2mat(name);
cc = abs(data - boom_feature);
% 查找出图片ID
picId_boom = find(cc<error);

if length(picId_boom)==0
    picId_boom = find(cc==min(cc));
end

picId = intersect(picId_right,picId_boom);

if length(picId)==0
    picId = union(picId_right,picId_boom);
end

% 回数据库查询图片
imgIndex=round(rand*(length(picId)-1)+1);
imgId = picId(imgIndex);


imgQueryText = ['select imgName from',' ',table_name,' ','where picId ='];
sql = strcat(imgQueryText,num2str(imgId));


% sql = strcat('select imgName from pic2 where picId = ',num2str(imgId));
curs = exec(conn,sql);
curs = fetch(curs);
imgId = curs.Data;
imgName = imgId{1};

close(conn)    

end