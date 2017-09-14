function mysqlConnectTest

% 连接成功，yes！！！！！

conn=database('sqltest','root','123456','com.mysql.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/sqltest');

curs = exec(conn,'select elementName from tbl_data_2');

curs = fetch(curs);
% cur =cell2mat(curs)
name = curs.Data

close(curs)

close(conn)

end

% 备份信息，存储+更新

% left_feature1 = num2cell(left_feature);
% 
% % insert语句的正确操作
% colNames = {'left_feature'};
% insert(conn,'pic1',colNames,left_feature1);

% update语句的正确操作
% whereClause = 'where left_feature = ''807899''';
% update(conn,'pic1',{'left_feature'},0,whereClause);