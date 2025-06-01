-- -----------------------------------------------------
-- Tabla sucursal
-- -----------------------------------------------------
CREATE TABLE sucursal (
    sucursal_id INT NOT NULL IDENTITY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    direccion VARCHAR(100) NOT NULL,
    numero_telefono VARCHAR(9),
    PRIMARY KEY(sucursal_id)
);

-- -----------------------------------------------------
-- Tabla persona
-- -----------------------------------------------------
CREATE TABLE persona (
    persona_id INT NOT NULL IDENTITY,
    direccion VARCHAR(100),
    numero_telefono VARCHAR(9) UNIQUE,
    email VARCHAR(100) UNIQUE,
    PRIMARY KEY (persona_id)
);

-- -----------------------------------------------------
-- Tabla persona_natural
-- -----------------------------------------------------
CREATE TABLE persona_natural (
    persona_natural_id INT NOT NULL,
    dni VARCHAR(8) NOT NULL UNIQUE,
    primer_nombre VARCHAR(100) NOT NULL,
    segundo_nombre VARCHAR(100),
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    PRIMARY KEY (persona_natural_id),
    CONSTRAINT fk_persona_natural_persona
        FOREIGN KEY (persona_natural_id)
        REFERENCES persona (persona_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Tabla persona_juridica
-- -----------------------------------------------------
CREATE TABLE persona_juridica (
    persona_juridica_id INT NOT NULL,
    ruc VARCHAR(11) NOT NULL UNIQUE,
    razon_social VARCHAR(100) NOT NULL,
    tipo VARCHAR(100),
    actividad_economica VARCHAR(100),
    tipo_factura VARCHAR(100),
    PRIMARY KEY (persona_juridica_id),
    CONSTRAINT fk_persona_juridica_persona
        FOREIGN KEY (persona_juridica_id)
        REFERENCES persona (persona_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Tabla rol
-- -----------------------------------------------------
CREATE TABLE rol (
    rol_id INT NOT NULL IDENTITY,
    nombre VARCHAR(45) NOT NULL UNIQUE,
    PRIMARY KEY (rol_id)
);

-- -----------------------------------------------------
-- Tabla empleado
-- -----------------------------------------------------
CREATE TABLE empleado (
    empleado_id INT NOT NULL,
    nombre_usuario VARCHAR(45) NOT NULL UNIQUE,
    contrasena VARCHAR(45) NOT NULL,
    rol_fk INT,
    sucursal_fk INT DEFAULT 2,
    PRIMARY KEY (empleado_id),
    CONSTRAINT fk_empleado_persona_natural
        FOREIGN KEY (empleado_id)
        REFERENCES persona_natural (persona_natural_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_empleado_rol
        FOREIGN KEY (rol_fk)
        REFERENCES rol (rol_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_empleado_sucursal
        FOREIGN KEY (sucursal_fk)
        REFERENCES sucursal (sucursal_id)
        ON DELETE SET NULL
);

-----------------------------------------------------
-- Tabla cliente_natural
-----------------------------------------------------
CREATE TABLE cliente_natural (
    cliente_natural_id INT NOT NULL,
    fecha_registro DATE,
    PRIMARY KEY (cliente_natural_id),
    CONSTRAINT fk_cliente_natural_persona_natural
        FOREIGN KEY (cliente_natural_id)
        REFERENCES persona_natural (persona_natural_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Tabla cliente_juridico
-- -----------------------------------------------------
CREATE TABLE cliente_juridico (
    cliente_juridico_id INT NOT NULL,
    fecha_registro DATE,
    PRIMARY KEY (cliente_juridico_id),
    CONSTRAINT fk_cliente_juridico_persona_juridica
        FOREIGN KEY (cliente_juridico_id)
        REFERENCES persona_juridica (persona_juridica_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Tabla mesa
-- -----------------------------------------------------
CREATE TABLE mesa (
    mesa_id INT NOT NULL IDENTITY,
    numero INT NOT NULL UNIQUE,
    capacidad INT NOT NULL,
    disponible BIT NOT NULL,
    mesero_fk INT,
    PRIMARY KEY (mesa_id),
    CONSTRAINT fk_mesa_empleado
        FOREIGN KEY (mesero_fk)
        REFERENCES empleado (empleado_id)
        ON DELETE SET NULL
);

-- -----------------------------------------------------
-- Tabla categoria_menu
-- -----------------------------------------------------
CREATE TABLE categoria_menu (
    categoria_menu_id INT NOT NULL IDENTITY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(200),
    PRIMARY KEY (categoria_menu_id)
);

-- -----------------------------------------------------
-- Tabla menu
-- -----------------------------------------------------
CREATE TABLE menu (
    menu_id INT NOT NULL IDENTITY,
    nombre VARCHAR(45) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    descripcion VARCHAR(200),
    disponible BIT NOT NULL,
    imagen VARCHAR(200) NOT NULL,
    categoria_menu_fk INT NOT NULL,
    PRIMARY KEY (menu_id),
    CONSTRAINT fk_menu_categoria_menu
        FOREIGN KEY (categoria_menu_fk)
        REFERENCES categoria_menu (categoria_menu_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Tabla pedido
-- -----------------------------------------------------
CREATE TABLE pedido (
    pedido_id INT NOT NULL IDENTITY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    activo BIT NOT NULL,
    mesero_fk INT,
    mesa_fk INT,
    PRIMARY KEY (pedido_id),
    CONSTRAINT fk_pedido_empleado
        FOREIGN KEY (mesero_fk)
        REFERENCES empleado (empleado_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_pedido_mesa
        FOREIGN KEY (mesa_fk)
        REFERENCES mesa (mesa_id)
        ON DELETE SET NULL
);

-- -----------------------------------------------------
-- Tabla pedido_detalle
-- -----------------------------------------------------
CREATE TABLE pedido_detalle (
    pedido_detalle_id INT NOT NULL IDENTITY,
    cantidad INT NOT NULL,
    observaciones VARCHAR(200),
    menu_fk INT,
    pedido_fk INT NOT NULL,
    PRIMARY KEY (pedido_detalle_id),
    CONSTRAINT fk_pedido_detalle_menu
        FOREIGN KEY (menu_fk)
        REFERENCES menu (menu_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_pedido_detalle_pedido
        FOREIGN KEY (pedido_fk)
        REFERENCES pedido (pedido_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Tabla tipo_pago
-- -----------------------------------------------------
CREATE TABLE tipo_pago (
    tipo_pago_id INT NOT NULL IDENTITY,
    tipo VARCHAR(45) NOT NULL UNIQUE,
    PRIMARY KEY (tipo_pago_id)
);

-- -----------------------------------------------------
-- Tabla comprobante
-- -----------------------------------------------------
CREATE TABLE comprobante (
    comprobante_id INT NOT NULL IDENTITY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    activo BIT,
    precio_total DECIMAL(10,2) NOT NULL,
    descuento DECIMAL(10,2),
    pagos_adicionales DECIMAL(10,2),
    igv DECIMAL(10,2) NOT NULL,
    cambio DECIMAL(10,2),
    cajero_fk INT,
    pedido_fk INT,
    tipo_pago_fk INT,
    sucursal_fk INT DEFAULT 2,
    PRIMARY KEY (comprobante_id),
    CONSTRAINT fk_comprobante_empleado
        FOREIGN KEY (cajero_fk)
        REFERENCES empleado (empleado_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_comprobante_pedido
        FOREIGN KEY (pedido_fk)
        REFERENCES pedido (pedido_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_comprobante_sucursal
        FOREIGN KEY (sucursal_fk)
        REFERENCES sucursal (sucursal_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_comprobante_tipo_pago
        FOREIGN KEY (tipo_pago_fk)
        REFERENCES tipo_pago (tipo_pago_id)
        ON DELETE SET NULL
);

-- -----------------------------------------------------
-- Tabla boleta
-- -----------------------------------------------------
CREATE TABLE boleta (
    boleta_id INT NOT NULL,
    cliente_natural_fk INT,
    PRIMARY KEY (boleta_id),
    CONSTRAINT fk_boleta_comprobante
        FOREIGN KEY (boleta_id)
        REFERENCES comprobante (comprobante_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_boleta_cliente_natural
        FOREIGN KEY (cliente_natural_fk)
        REFERENCES cliente_natural (cliente_natural_id)
        ON DELETE SET NULL
);

-- -----------------------------------------------------
-- Tabla factura
-- -----------------------------------------------------
CREATE TABLE factura (
    factura_id INT NOT NULL,
    cliente_juridico_fk INT,
    PRIMARY KEY (factura_id),
    CONSTRAINT fk_factura_comprobante
        FOREIGN KEY (factura_id)
        REFERENCES comprobante (comprobante_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_factura_cliente_juridico
        FOREIGN KEY (cliente_juridico_fk)
        REFERENCES cliente_juridico (cliente_juridico_id)
        ON DELETE SET NULL
);