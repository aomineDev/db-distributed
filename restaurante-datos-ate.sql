INSERT INTO sucursal (nombre, direccion, numero_telefono)
VALUES 
('Restaurante ATE', 'Av. La Molina 150, Ate', '013456789'),
('Restaurante La Molina', 'Jr. Los Claveles 200, La Molina', '019876543');

INSERT INTO rol (nombre)
VALUES
('Administrador'),
('Mesero'),
('Cajero');

INSERT INTO categoria_menu (nombre, descripcion)
VALUES
('Entradas', 'Platos ligeros para empezar.'),
('Platos Principales', 'Nuestras especialidades fuertes.'),
('Bebidas', 'Variedad de refrescos y licores.'),
('Postres', 'Dulces para finalizar la comida.');

INSERT INTO menu (nombre, precio_unitario, descripcion, disponible, imagen, categoria_menu_fk)
VALUES
('Causa Rellena', 25.00, 'Deliciosa causa de papa amarilla con atún.', 1, '/img/causa.jpg', 1),
('Lomo Saltado', 45.50, 'Clásico lomo saltado con papas fritas y arroz.', 1, '/img/lomo.jpg', 2),
('Jugo de Maracuyá', 12.00, 'Refrescante jugo natural de maracuyá.', 1, '/img/maracuya.jpg', 3),
('Suspiro a la Limeña', 18.00, 'Tradicional postre limeño.', 1, '/img/suspiro.jpg', 4);

INSERT INTO tipo_pago (tipo)
VALUES
('Efectivo'),
('Tarjeta de Crédito/Débito'),
('Yape/Plin');

EXEC insertar_empleado
    @direccion = 'Calle Los Andes 10, Ate',
    @numero_telefono = '911222333',
    @email = 'admin.ate@rest.com',
    @dni = '1234567A',
    @primer_nombre = 'Carlos',
    @segundo_nombre = NULL,
    @apellido_paterno = 'Ramírez',
    @apellido_materno = 'Soto',
    @fecha_nacimiento = '1985-01-20',
    @nombre_usuario = 'carlos.r',
    @contrasena = 'adminPass123',
    @rol_fk = 1;

EXEC insertar_empleado
    @direccion = 'Av. Primavera 500, Ate',
    @numero_telefono = '922333444',
    @email = 'mesero.ate@rest.com',
    @dni = '8765432B',
    @primer_nombre = 'Sofía',
    @segundo_nombre = 'Isabel',
    @apellido_paterno = 'Vargas',
    @apellido_materno = 'León',
    @fecha_nacimiento = '1992-11-03',
    @nombre_usuario = 'sofia.v',
    @contrasena = 'meseroPass456',
    @rol_fk = 2;


EXEC insertar_empleado
    @direccion = 'Jr. San Martín 75, Ate',
    @numero_telefono = '933444555',
    @email = 'cajero.ate@rest.com',
    @dni = '4567891C',
    @primer_nombre = 'Luis',
    @segundo_nombre = NULL,
    @apellido_paterno = 'Flores',
    @apellido_materno = 'Paredes',
    @fecha_nacimiento = '1995-07-22',
    @nombre_usuario = 'luis.f',
    @contrasena = 'cajeroPass789',
    @rol_fk = 3;

EXEC insertar_cliente_natural
    @direccion = 'Av. Benavides 100, Miraflores',
    @numero_telefono = '944555666',
    @email = 'ana.rojas@mail.com',
    @dni = '01010101',
    @primer_nombre = 'Ana',
    @segundo_nombre = NULL,
    @apellido_paterno = 'Rojas',
    @apellido_materno = 'Castro',
    @fecha_nacimiento = '1988-03-10';

EXEC insertar_cliente_natural
    @direccion = 'Calle Las Flores 25, Surco',
    @numero_telefono = '955666777',
    @email = 'pedro.diaz@mail.com',
    @dni = '02020202',
    @primer_nombre = 'Pedro',
    @segundo_nombre = 'Alberto',
    @apellido_paterno = 'Díaz',
    @apellido_materno = 'Morales',
    @fecha_nacimiento = '1991-09-25';

EXEC insertar_cliente_juridico
    @direccion = 'Av. Arequipa 300, San Isidro',
    @numero_telefono = '014001000',
    @email = 'contacto@negociofast.com',
    @ruc = '20123456789',
    @razon_social = 'Negocio Fast S.A.C.',
    @tipo = 'SAC',
    @actividad_economica = 'Venta de Productos',
    @tipo_factura = 'Factura Electrónica';

INSERT INTO mesa (numero, capacidad, disponible, mesero_fk)
VALUES
(1, 4, 1, 2),
(2, 6, 1, 2);

INSERT INTO pedido (fecha, hora, activo, mesero_fk, mesa_fk)
VALUES
(GETDATE(), GETDATE(), 1, 2, 1),
(GETDATE(), GETDATE(), 1, 2, 2);

INSERT INTO pedido_detalle (cantidad, observaciones, menu_fk, pedido_fk)
VALUES
(2, 'Sin ají', 1, 1),
(3, NULL, 3, 1),
(1, 'Medio cocido', 2, 2);

EXEC insertar_boleta
    @precio_total = 72.00,
    @descuento = 0.00,
    @pagos_adicionales = 0.00,
    @igv = 18.00,
    @cambio = 0.00,
    @cajero_fk = 3,
    @pedido_fk = 1,
    @tipo_pago_fk = 1,
    @cliente_natural_fk = 4;

EXEC insertar_factura
    @precio_total = 53.60,
    @descuento = 0.00,
    @pagos_adicionales = 0.00,
    @igv = 18.00,
    @cambio = 0.00,
    @cajero_fk = 3,
    @pedido_fk = 2,
    @tipo_pago_fk = 2,
    @cliente_juridico_fk = 6;