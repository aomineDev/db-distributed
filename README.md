# Base de datos distribuida

## Permitir ping entre 2 nodos:
- pasar de red public a privada
- ctrl + r
- wf.msc
- reglas de entrada
- habilitar reglas
	- uso compartido de archivos e impresoras (ICMPv4)
	- compartir archivos e impresoras (ICMPv4)
	- archivos e impresoras compartidos (ICMPv4)

## Obtener Ip (host):
- cmd -> adaptador lan wifi -> direccion ipv4

## Obtener ip (virtual machine):
- Vm -> Cofiuracion -> red -> Adaptador 1 -> Adaptador Puente
- cmd -> ipconfig -> adaptador ethernet -> direcion ipv4

## acer ping:
- ambos ips tiene que ser similiares excepto el ultimo numero:
- ip host(ejemplo): 192.168.1.x
- ip vm(ejemplo): 192.168.1.x
- cmd -> ping usar.la.otra.ip

## Activar Login sql server
- server -> propiedades -> seguridad -> Modo de autenticacion de windows y sql server
- server -> reiniciar
- seguridad -> inicio de sesion -> sa
- cambiar la contraseña

## Habilitar comnuicacion de sql server
- Abrir SQL Server Configuration Manager
- SQL Server Network Configuration -> Protocols for MSSQLSERVER/SQLEXPRESS
- Habilitar TCP/IP
- TCP/IP -> Ip Addresses -> IPAII -> TCP Port: 1433

## Reiniciar totalmente sql server
- Abrir SQL Server Configuration Manager
- SQL Server Configuration Manager -> SQL Server Services -> SQL SERVER (NOMBRE DE LA INSTANCIA)
- Click derecho y restart

## Habilitar puerto 1433
- wf.msc -> Reglas de entrada -> nueva Regla
- Puerto -> TCp - 1433 -> Permitir la conexión -> Privado -> SQL Server TCP 1433
- Probar puerto
	- en la otra pc abrir powershell
	- Test-NetConnection -ComputerName la.ip.de.otraPc -Port 1433

## Habilitar puerto 1433 (segunda forma)
- Abrir powershell como administrador
- New-NetFirewallRule -DisplayName "SQL SERVER TCP 1433" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action Allow

## Crear Server Link (Desde SSMS)
- instancia -> objetos de servidor -> servidores vinculados -> Nuevo servidor Vinculado
- Colocar nombre de la otra instancia o ip + puerto (x.x.x.x,puerto)
- Seguridad -> Se establecerán usado este context de seguridad(ultima opcion)
- colocar credenciales de la otra instancia

## Crear Server Link
EXEC sp_addlinkedserver 
@server='ServerAlias',
@srvproduct='',
@provider='MSOLEDBSQL',
@datasrc='nombre de la instancia o tambien x.x.x.x,puerto'; 

EXEC sp_addlinkedsrvlogin
@rmtsrvname='ServerAlias',
@useself='false',
@locallogin=NULL,
@rmtuser='usuario',
@rmtpassword='contraseña';

# Transacciones Distribuidas

## Activar Transacciones distribuidas
EXEC sp_serveroption 'SQLVM', 'rpc', true;
EXEC sp_serveroption 'SQLVM', 'rpc out', true;
EXEC sp_serveroption 'SQLVM', 'data access', true;
EXEC sp_serveroption 'SQLVM', 'remote proc transaction promotion', true;

## Activar MSDTC
- ctrl + r -> dcomcnfg
- servicios de componentes -> equipos -> mi Pc -> Coordinador de transacciones distribuidas -> DTC local -> Porpiedades -> Seguridad
- activar
	- Acceso a DTC desde la red
	- Permitir clientes remotos
	- Permitir administracion remota
	- Permitir entrantes
	- Permitir salientes
	- No se requiere autenticación
	- Habilitar transacciones XA

## Habilitar puerto 135
- wf.msc -> Reglas de entrada -> nueva Regla
- Puerto -> TCp - 135 -> Permitir la conexión -> Privado -> MSDTC TCP 135
- Probar puerto
	- en la otra pc abrir powershell
	- Test-NetConnection -ComputerName la.ip.de.otraPc -Port 135

## Habilitar puerto 135 (segunda forma)
- Abrir powershell como administrador
- New-NetFirewallRule -DisplayName "MSDTC TCP 135" -Direction Inbound -Protocol TCP -LocalPort 135 -Action Allow

## Habilitar DTC Firewall
- ctrl + r -> +wf.msc -> Reglas de entrada
- Habilitar las reglas
	- Coordinador de transacciones distribuidas (todas)

> Todas las trasacciones distribuididas tienen que empeza con `SET XACT_ABORT ON`;

# Extra

## Conectarse a SQL Server remotamentoe usando nombre de la instancia

### SQL Server Browser 
- ctrl + r -> services.msc -> SQL Server Browser
- click derecho -> Propiedades
- Tipo de inicio -> Manual/automatico

### Activar Puerto dp 1434
- wf.msc -> Reglas de entrada -> nueva Regla
- Puerto -> UDP - 1434 -> Permitir la conexión -> Privado -> SQL Browser UDP 1434
