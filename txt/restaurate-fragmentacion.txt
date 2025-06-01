CREATE VIEW vista_empleado_global AS
SELECT *
FROM vista_empleado
UNION ALL
SELECT *
FROM x.x.dbo.vista_empleado;