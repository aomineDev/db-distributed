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
    @direccion = 'Av. Flora Tristán 100, La Molina',
    @numero_telefono = '944000111',
    @email = 'admin.molina@rest.com',
    @dni = '11122233',
    @primer_nombre = 'Elena',
    @segundo_nombre = NULL,
    @apellido_paterno = 'Ruiz',
    @apellido_materno = 'García',
    @fecha_nacimiento = '1987-08-01',
    @nombre_usuario = 'elena.r',
    @contrasena = 'molinaAdmin123',
    @rol_fk = 1;

EXEC insertar_empleado
    @direccion = 'Jr. Los Rosales 50, La Molina',
    @numero_telefono = '955111222',
    @email = 'mesero.molina.2@rest.com',
    @dni = '44455566',
    @primer_nombre = 'Mario',
    @segundo_nombre = 'Andrés',
    @apellido_paterno = 'Nuñez',
    @apellido_materno = 'Reyes',
    @fecha_nacimiento = '1993-04-12',
    @nombre_usuario = 'mario.n',
    @contrasena = 'molinaMesero456',
    @rol_fk = 2;

EXEC insertar_empleado
    @direccion = 'Av. Javier Prado Este 2000, La Molina',
    @numero_telefono = '966222333',
    @email = 'cajero.molina@rest.com',
    @dni = '77788899',
    @primer_nombre = 'Paula',
    @segundo_nombre = NULL,
    @apellido_paterno = 'Castro',
    @apellido_materno = 'Morales',
    @fecha_nacimiento = '1996-02-28',
    @nombre_usuario = 'paula.c',
    @contrasena = 'molinaCajero789',
    @rol_fk = 3;

EXEC insertar_cliente_natural
    @direccion = 'Av. Raúl Ferrero 123, La Molina',
    @numero_telefono = '977333444',
    @email = 'juan.perez@mail.com',
    @dni = '03030303',
    @primer_nombre = 'Juan',
    @segundo_nombre = NULL,
    @apellido_paterno = 'Pérez',
    @apellido_materno = 'Gómez',
    @fecha_nacimiento = '1980-06-05';

EXEC insertar_cliente_natural
    @direccion = 'Calle El Sauce 15, La Molina',
    @numero_telefono = '988444555',
    @email = 'laura.sanchez@mail.com',
    @dni = '04040404',
    @primer_nombre = 'Laura',
    @segundo_nombre = 'Patricia',
    @apellido_paterno = 'Sánchez',
    @apellido_materno = 'Ríos',
    @fecha_nacimiento = '1994-10-18';

EXEC insertar_cliente_juridico
    @direccion = 'Av. La Fontana 500, La Molina',
    @numero_telefono = '015002000',
    @email = 'info@serviciospro.com',
    @ruc = '20987654321',
    @razon_social = 'Servicios Pro S.A.C.',
    @tipo = 'SAC',
    @actividad_economica = 'Consultoría',
    @tipo_factura = 'Factura Electrónica';

INSERT INTO mesa (numero, capacidad, disponible, mesero_fk)
VALUES
(3, 4, 1, 2),
(4, 8, 1, 2);

INSERT INTO pedido (fecha, hora, activo, mesero_fk, mesa_fk)
VALUES
(GETDATE(), GETDATE(), 1, 2, 1),
(GETDATE(), GETDATE(), 1, 2, 2);

INSERT INTO pedido_detalle (cantidad, observaciones, menu_fk, pedido_fk)
VALUES
(1, NULL, 2, 1),
(2, 'Con poco azúcar', 3, 1),
(1, NULL, 4, 2);

EXEC insertar_boleta
    @precio_total = 69.50,
    @descuento = 0.00,
    @pagos_adicionales = 0.00,
    @igv = 18.00,
    @cambio = 0.00,
    @cajero_fk = 3,
    @pedido_fk = 1,
    @tipo_pago_fk = 2,
    @cliente_natural_fk = 4;

EXEC insertar_factura
    @precio_total = 21.24,
    @descuento = 0.00,
    @pagos_adicionales = 0.00,
    @igv = 18.00,
    @cambio = 0.00,
    @cajero_fk = 3,
    @pedido_fk = 2,
    @tipo_pago_fk = 1,
    @cliente_juridico_fk = 6;