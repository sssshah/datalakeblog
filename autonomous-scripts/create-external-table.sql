begin
  DBMS_CLOUD.create_credential(
    credential_name => 'samcredential',
    username => 'samir.s.shah',
    password => 'rkN><wTDBGSKUoTi846a'
  );
end;
/

drop table patient_ext_table;

BEGIN

  DBMS_CLOUD.CREATE_EXTERNAL_TABLE (
   table_name =>'PATIENT_EXT_TABLE',
   credential_name =>'samcredential',
   format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true'),
   file_uri_list =>'https://objectstorage.us-ashburn-1.oraclecloud.com/n/idgi4v1vpoej/b/patient-test/o/*',
   column_list => 'patient_id number, name varchar2(30), zip varchar2(5)'
);
end;
/

BEGIN
  DBMS_CLOUD.CREATE_EXTERNAL_TABLE (
   table_name =>'ZIP_TABLE',
   credential_name =>'samcredential',
   format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true'),
   file_uri_list =>'https://objectstorage.us-ashburn-1.oraclecloud.com/n/idgi4v1vpoej/b/reference-data/o/zip.txt',
   column_list => 'zip varchar2(5), city varchar2(30)'
);
end;
/


begin
DBMS_CLOUD.VALIDATE_EXTERNAL_TABLE(
	table_name=>   'patient_ext_table'
);
end;
/

