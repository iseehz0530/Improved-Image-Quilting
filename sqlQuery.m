function name = sqlQuery(feature_name)
% (feature_name,database_name,table_name)
% database_name = 'imgmarket';
% table_name = 'pic2';

global database_name;
global table_name;

feature_name = 'right_feature';

jdbcUrl = strcat('jdbc:mysql://127.0.0.1:3306/',database_name);
conn=database(database_name,'root','123456','com.mysql.jdbc.Driver',jdbcUrl);

sqlStatement = ['select',' ',feature_name,' ',' from ',' ',table_name];
curs_left = exec(conn,sqlStatement);

curs_left = fetch(curs_left);
% cur =cell2mat(curs)
name = curs_left.Data;
% 提取出数据后，关闭curs
close(curs_left)


end