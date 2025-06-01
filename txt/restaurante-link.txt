EXEC sp_addlinkedserver 
@server='RestauranteMolina',
@srvproduct='',
@provider='MSOLEDBSQL',
@datasrc='x.x.x.x';

EXEC sp_addlinkedsrvlogin
@rmtsrvname='RestauranteMolina',
@useself='false',
@locallogin=NULL,
@rmtuser='sa',
@rmtpassword='123';

EXEC sp_serveroption 'SQLVM', 'rpc', true;
EXEC sp_serveroption 'SQLVM', 'rpc out', true;
EXEC sp_serveroption 'SQLVM', 'data access', true;
EXEC sp_serveroption 'SQLVM', 'remote proc transaction promotion', true;