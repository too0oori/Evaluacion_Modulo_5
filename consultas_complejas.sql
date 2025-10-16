-- Consultas Complejas

  --  Realiza una consulta que recupere el total de ventas de un producto durante el mes anterior.

SELECT p.nombre, SUM(t.cantidad) AS total_vendido
FROM productos p
JOIN transaccion t ON p.id = t.producto_id
WHERE t.tipo = 'VENTA' AND t.fecha < '2024-10-01'
GROUP BY p.nombre;


  --  Utiliza JOINs (INNER, LEFT) para obtener información relacionada entre las tablas productos, proveedores y transacciones.
--todas las transacciones con detalles de producto y proveedor
SELECT t.id AS transaccion_id, t.tipo, t.fecha, t.cantidad, p.nombre AS producto, pr.nombre AS proveedor
FROM transaccion t
INNER JOIN productos p ON t.producto_id = p.id
INNER JOIN proveedores pr ON t.proveedor_id = pr.id;

--productos que no han tenido transacciones
SELECT pr.id as proveedor_id, pr.nombre as proveedor, p.nombre as producto
FROM proveedores pr
INNER JOIN productos p ON pr.id = p.proveedor_id
LEFT JOIN transaccion t ON p.id = t.producto_id
WHERE t.id IS NULL;

  --  Implementa una consulta con subconsultas (subqueries) para obtener productos que no se han vendido durante un período determinado.
-- mostrar los productos que no se han vendido (aunque sí se hayan comprado).
SELECT p.id AS producto_id, p.nombre AS producto, p.stock, pr.nombre AS proveedor
FROM productos p
INNER JOIN proveedores pr ON p.proveedor_id = pr.id
WHERE p.id NOT IN (
    SELECT DISTINCT t.producto_id
    FROM transaccion t
    WHERE t.tipo = 'VENTA' AND t.fecha >= '2024-09-01' AND t.fecha < '2024-09-30'
);