CREATE VIEW vista_empleado AS
SELECT
    e.empleado_id,
    e.nombre_usuario,
    p.direccion,
    p.numero_telefono,
    p.email,
    pn.dni,
    pn.primer_nombre,
    pn.segundo_nombre,
    pn.apellido_paterno,
    pn.apellido_materno,
    pn.fecha_nacimiento,
    e.rol_fk AS rol_id,
    r.nombre AS nombre_rol,
    e.sucursal_fk AS sucursal_id,
    s.nombre AS nombre_sucursal
FROM
    empleado AS e
INNER JOIN
    persona_natural AS pn ON e.empleado_id = pn.persona_natural_id
INNER JOIN
    persona AS p ON pn.persona_natural_id = p.persona_id
LEFT JOIN
    rol AS r ON e.rol_fk = r.rol_id
LEFT JOIN
    sucursal AS s ON e.sucursal_fk = s.sucursal_id;


CREATE VIEW vista_cliente_natural AS
SELECT
    cn.cliente_natural_id,
    cn.fecha_registro,
    p.direccion,
    p.numero_telefono,
    p.email,
    pn.dni,
    pn.primer_nombre,
    pn.segundo_nombre,
    pn.apellido_paterno,
    pn.apellido_materno,
    pn.fecha_nacimiento
FROM
    cliente_natural AS cn
INNER JOIN
    persona_natural AS pn ON cn.cliente_natural_id = pn.persona_natural_id
INNER JOIN
    persona AS p ON pn.persona_natural_id = p.persona_id;


CREATE VIEW vista_cliente_juridico AS
SELECT
    cj.cliente_juridico_id,
    cj.fecha_registro,
    p.direccion,
    p.numero_telefono,
    p.email,
    pj.ruc,
    pj.razon_social,
    pj.tipo AS tipo_persona_juridica,
    pj.actividad_economica,
    pj.tipo_factura
FROM
    cliente_juridico AS cj
INNER JOIN
    persona_juridica AS pj ON cj.cliente_juridico_id = pj.persona_juridica_id
INNER JOIN
    persona AS p ON pj.persona_juridica_id = p.persona_id;


CREATE VIEW vista_boleta AS
SELECT
    b.boleta_id,
    c.fecha AS fecha_comprobante,
    c.hora AS hora_comprobante,
    c.activo AS comprobante_activo,
    c.precio_total,
    c.descuento,
    c.pagos_adicionales,
    c.igv,
    c.cambio,
    CONCAT(emp_pn.primer_nombre, ' ', emp_pn.apellido_paterno) AS cajero,
    c.pedido_fk AS pedido_id,
    c.tipo_pago_fk AS tipo_pago_id,
    tp.tipo AS tipo_pago_nombre,
    c.sucursal_fk AS sucursal_id_comprobante,
    suc.nombre AS nombre_sucursal_comprobante,
    CONCAT(cli_pn.primer_nombre, ' ', cli_pn.apellido_paterno) AS cliente_natural,
    cli_pn.dni AS dni_cliente_natural
FROM
    boleta AS b
INNER JOIN
    comprobante AS c ON b.boleta_id = c.comprobante_id
LEFT JOIN
    empleado AS emp ON c.cajero_fk = emp.empleado_id
LEFT JOIN
    persona_natural AS emp_pn ON emp.empleado_id = emp_pn.persona_natural_id
LEFT JOIN
    tipo_pago AS tp ON c.tipo_pago_fk = tp.tipo_pago_id
LEFT JOIN
    sucursal AS suc ON c.sucursal_fk = suc.sucursal_id
LEFT JOIN
    cliente_natural AS cli_cn ON b.cliente_natural_fk = cli_cn.cliente_natural_id
LEFT JOIN
    persona_natural AS cli_pn ON cli_cn.cliente_natural_id = cli_pn.persona_natural_id;


CREATE VIEW vista_factura AS
SELECT
    f.factura_id,
    c.fecha AS fecha_comprobante,
    c.hora AS hora_comprobante,
    c.activo AS comprobante_activo,
    c.precio_total,
    c.descuento,
    c.pagos_adicionales,
    c.igv,
    c.cambio,
    CONCAT(emp_pn.primer_nombre, ' ', emp_pn.apellido_paterno) AS cajero,
    c.pedido_fk AS pedido_id,
    c.tipo_pago_fk AS tipo_pago_id,
    tp.tipo AS tipo_pago_nombre,
    c.sucursal_fk AS sucursal_id_comprobante,
    suc.nombre AS nombre_sucursal_comprobante,
    pj.razon_social AS razon_social_cliente_juridico,
    pj.ruc AS ruc_cliente_juridico
FROM
    factura AS f
INNER JOIN
    comprobante AS c ON f.factura_id = c.comprobante_id
LEFT JOIN
    empleado AS emp ON c.cajero_fk = emp.empleado_id
LEFT JOIN
    persona_natural AS emp_pn ON emp.empleado_id = emp_pn.persona_natural_id
LEFT JOIN
    tipo_pago AS tp ON c.tipo_pago_fk = tp.tipo_pago_id
LEFT JOIN
    sucursal AS suc ON c.sucursal_fk = suc.sucursal_id
LEFT JOIN
    persona_juridica AS pj ON f.cliente_juridico_fk = pj.persona_juridica_id;


