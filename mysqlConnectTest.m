function mysqlConnectTest

% ���ӳɹ���yes����������

conn=database('sqltest','root','123456','com.mysql.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/sqltest');

curs = exec(conn,'select elementName from tbl_data_2');

curs = fetch(curs);
% cur =cell2mat(curs)
name = curs.Data

close(curs)

close(conn)

end

% ������Ϣ���洢+����

% left_feature1 = num2cell(left_feature);
% 
% % insert������ȷ����
% colNames = {'left_feature'};
% insert(conn,'pic1',colNames,left_feature1);

% update������ȷ����
% whereClause = 'where left_feature = ''807899''';
% update(conn,'pic1',{'left_feature'},0,whereClause);