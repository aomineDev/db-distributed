CREATE PROCEDURE insertar_empleado
    @direccion VARCHAR(100),
    @numero_telefono VARCHAR(9),
    @email VARCHAR(100),
    @dni VARCHAR(8),
    @primer_nombre VARCHAR(100),
    @segundo_nombre VARCHAR(100),
    @apellido_paterno VARCHAR(100),
    @apellido_materno VARCHAR(100),
    @fecha_nacimiento DATE,
    @nombre_usuario VARCHAR(45),
    @contrasena VARCHAR(45),
    @rol_fk INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @persona_id INT;

        INSERT INTO persona (direccion, numero_telefono, email)
        VALUES (@direccion, @numero_telefono, @email);

        SET @persona_id = SCOPE_IDENTITY();

        INSERT INTO persona_natural (persona_natural_id, dni, primer_nombre, segundo_nombre, apellido_paterno, apellido_materno, fecha_nacimiento)
        VALUES (@persona_id, @dni, @primer_nombre, @segundo_nombre, @apellido_paterno, @apellido_materno, @fecha_nacimiento);

        INSERT INTO empleado (empleado_id, nombre_usuario, contrasena, rol_fk)
        VALUES (@persona_id, @nombre_usuario, @contrasena, @rol_fk);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        RAISERROR('Hubo un fallo al insertar un empleado.', 16, 1);
    END CATCH;
END;


CREATE PROCEDURE insertar_cliente_natural
    @direccion VARCHAR(100),
    @numero_telefono VARCHAR(9),
    @email VARCHAR(100),
    @dni VARCHAR(8),
    @primer_nombre VARCHAR(100),
    @segundo_nombre VARCHAR(100),
    @apellido_paterno VARCHAR(100),
    @apellido_materno VARCHAR(100),
    @fecha_nacimiento DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @persona_id INT;

        INSERT INTO persona (direccion, numero_telefono, email)
        VALUES (@direccion, @numero_telefono, @email);

        SET @persona_id = SCOPE_IDENTITY();

        INSERT INTO persona_natural (persona_natural_id, dni, primer_nombre, segundo_nombre, apellido_paterno, apellido_materno, fecha_nacimiento)
        VALUES (@persona_id, @dni, @primer_nombre, @segundo_nombre, @apellido_paterno, @apellido_materno, @fecha_nacimiento);

        INSERT INTO cliente_natural (cliente_natural_id, fecha_registro)
        VALUES (@persona_id, GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        RAISERROR('Hubo un fallo al insertar un cliente natural.', 16, 2);
    END CATCH;
END;


CREATE PROCEDURE insertar_cliente_juridico
    @direccion VARCHAR(100),
    @numero_telefono VARCHAR(9),
    @email VARCHAR(100),
    @ruc VARCHAR(11),
    @razon_social VARCHAR(100),
    @tipo VARCHAR(100),
    @actividad_economica VARCHAR(100),
    @tipo_factura VARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @persona_id INT;

        INSERT INTO persona (direccion, numero_telefono, email)
        VALUES (@direccion, @numero_telefono, @email);

        SET @persona_id = SCOPE_IDENTITY();

        INSERT INTO persona_juridica (persona_juridica_id, ruc, razon_social, tipo, actividad_economica, tipo_factura)
        VALUES (@persona_id, @ruc, @razon_social, @tipo, @actividad_economica, @tipo_factura);

        INSERT INTO cliente_juridico (cliente_juridico_id, fecha_registro)
        VALUES (@persona_id, GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        RAISERROR('Hubo un fallo al insertar un cliente jurídico.', 16, 3);
    END CATCH;
END;


CREATE PROCEDURE insertar_boleta
    @precio_total DECIMAL(10,2),
    @descuento DECIMAL(10,2),
    @pagos_adicionales DECIMAL(10,2),
    @igv DECIMAL(10,2),
    @cambio DECIMAL(10,2),
    @cajero_fk INT,
    @pedido_fk INT,
    @tipo_pago_fk INT,
    @cliente_natural_fk INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @comprobante_id INT;

        INSERT INTO comprobante (fecha, hora, activo, precio_total, descuento, pagos_adicionales, igv, cambio, cajero_fk, pedido_fk, tipo_pago_fk)
        VALUES (GETDATE(), GETDATE(), 1, @precio_total, @descuento, @pagos_adicionales, @igv, @cambio, @cajero_fk, @pedido_fk, @tipo_pago_fk);

        SET @comprobante_id = SCOPE_IDENTITY();

        INSERT INTO boleta (boleta_id, cliente_natural_fk)
        VALUES (@comprobante_id, @cliente_natural_fk);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        RAISERROR('Hubo un fallo al insertar una boleta.', 16, 4);
    END CATCH;
END;


CREATE PROCEDURE insertar_factura
    @precio_total DECIMAL(10,2),
    @descuento DECIMAL(10,2),
    @pagos_adicionales DECIMAL(10,2),
    @igv DECIMAL(10,2),
    @cambio DECIMAL(10,2),
    @cajero_fk INT,
    @pedido_fk INT,
    @tipo_pago_fk INT,
    @cliente_juridico_fk INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @comprobante_id INT;

        INSERT INTO comprobante (fecha, hora, activo, precio_total, descuento, pagos_adicionales, igv, cambio, cajero_fk, pedido_fk, tipo_pago_fk)
        VALUES (GETDATE(), GETDATE(), 1, @precio_total, @descuento, @pagos_adicionales, @igv, @cambio, @cajero_fk, @pedido_fk, @tipo_pago_fk);

        SET @comprobante_id = SCOPE_IDENTITY();

        INSERT INTO factura (factura_id, cliente_juridico_fk)
        VALUES (@comprobante_id, @cliente_juridico_fk);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        RAISERROR('Hubo un fallo al insertar una factura.', 16, 5);
    END CATCH;
END;