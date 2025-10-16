DROP DATABASE IF EXISTS sistema_inventario_db;
CREATE DATABASE IF NOT EXISTS sistema_inventario_db;
USE sistema_inventario_db;

CREATE TABLE IF NOT EXISTS proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    CONSTRAINT check_email CHECK (email LIKE '%_@__%.__%')
);

CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    proveedor_id INT,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id),
    CONSTRAINT check_precio CHECK (precio > 0),
    CONSTRAINT check_stock CHECK (stock >= 0),
    CONSTRAINT fk_producto_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE

);

CREATE TABLE IF NOT EXISTS transaccion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    tipo ENUM('COMPRA', 'VENTA') NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT check_cantidad_transaccion CHECK (cantidad > 0),
    CONSTRAINT fk_transaccion_producto
    FOREIGN KEY (producto_id) REFERENCES productos(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
);

CREATE INDEX idx_producto_nombre ON productos(nombre);
CREATE INDEX idx_transaccion_fecha ON transaccion(fecha);
CREATE INDEX idx_transaccion_tipo ON transaccion(tipo);

--Proveedores
INSERT INTO proveedores (nombre, direccion, telefono, email) VALUES
('TechSupply S.A.', 'Av. Providencia 1234, Santiago', '+56912345678', 'contacto@techsupply.cl'),
('ElectroMax Ltda.', 'Calle O''Higgins 567, Valparaíso', '+56987654321', 'ventas@electromax.cl'),
('Distribuidora Global', 'Los Leones 890, Las Condes', '+56923456789', 'info@distglobal.cl'),
('Import Tech Chile', 'Paseo Bulnes 456, Santiago Centro', '+56934567890', 'pedidos@importtech.cl'),
('Mega Suministros', 'Av. Vicuña Mackenna 3000, Ñuñoa', '+56945678901', 'ventas@megasuministros.cl');

--Productos
INSERT INTO productos (nombre, descripcion, precio, stock, proveedor_id) VALUES
('Laptop Dell XPS 13', 'Laptop ultradelgada con procesador Intel i7, 16GB RAM, 512GB SSD', 899990.00, 15, 1),
('Monitor LG 27" 4K', 'Monitor IPS 4K de 27 pulgadas con HDR10', 349990.00, 20, 1),
('Disco SSD Samsung 1TB', 'Unidad de estado sólido NVMe M.2, velocidad 3500MB/s', 149990.00, 40, 3),
('Router TP-Link AX3000', 'Router Wi-Fi 6 de doble banda con 4 antenas', 89990.00, 25, 4),
('Mouse Logitech MX Master 3', 'Mouse inalámbrico ergonómico con sensor de 4000 DPI', 79990.00, 50, 2);

-- Transacciones
INSERT INTO transaccion (producto_id, tipo, fecha, cantidad) VALUES
(1, 1, 'VENTA', '2024-09-01', 20),
(2, 1, 'COMPRA', '2024-09-01', 30),
(3, 1, 'VENTA', '2024-09-03', 50),
(5, 2, 'COMPRA', '2024-09-05', 100);


