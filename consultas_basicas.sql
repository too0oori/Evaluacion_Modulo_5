-- consultas_basicas.sql
-- Recupera todos los productos disponibles en el inventario.
SELECT p.stock, p.nombre
FROM productos p
WHERE p.stock >= 1;

-- Recupera todos los proveedores que suministran productos específicos.
SELECT pr.nombre AS proveedor, p.nombre AS producto
FROM proveedores pr
JOIN productos p ON pr.id = p.proveedor_id
WHERE p.nombre = 'Laptop Dell XPS 13';

--Consulta las transacciones realizadas en una fecha específica

SELECT t.*, p.nombre AS producto, pr.nombre AS proveedor
FROM transaccion t
JOIN productos p ON t.producto_id = p.id
JOIN proveedores pr ON p.proveedor_id = pr.id
WHERE fecha = '2024-09-01';

--Realiza consultas de selección con funciones de agrupación, como COUNT() y SUM(), para calcular el número total de productos vendidos o el valor total de las compras.

--Número total de productos vendidos
SELECT SUM(cantidad) AS total_productos_vendidos
FROM transaccion
WHERE tipo = 'VENTA';

--Valor total de las ventas por producto
SELECT p.nombre, SUM(t.cantidad) AS cantidad_vendida, SUM(t.cantidad * p.precio) AS valor_total_ventas
FROM productos p
JOIN transaccion t ON p.id = t.producto_id
WHERE t.tipo = 'VENTA'
GROUP BY p.nombre;

--Valor total de las compras por producto
SELECT p.nombre, SUM(t.cantidad) AS cantidad_comprada, SUM(t.cantidad * p.precio) AS valor_total_ventas
FROM productos p
JOIN transaccion t ON p.id = t.producto_id
WHERE t.tipo = 'COMPRA'
GROUP BY p.nombre;