-- Transacciones SQL
USE sistema_inventario_db;
  --  Realiza una transacción para registrar una compra de productos. Utiliza el comando BEGIN TRANSACTION, COMMIT y ROLLBACK para asegurar que los cambios se apliquen correctamente.
START TRANSACTION;
--bloqueo de fila para evitar condiciones de carrera
SELECT stock FROM productos WHERE id = 1 FOR UPDATE; 
INSERT INTO transaccion (producto_id, proveedor_id, tipo, fecha, cantidad)    --  Asegúrate de que los cambios en la cantidad de inventario y las transacciones se realicen de forma atómica.
VALUES (1, 1, 'COMPRA', '2024-09-01', 5);

UPDATE productos
SET stock = stock + 5
WHERE id = 1;

COMMIT;

-- Verificación de la transacción
SELECT * FROM transaccion WHERE producto_id = 1 ORDER BY id DESC;
SELECT id, nombre, stock FROM productos WHERE id = 1;



  --  Utiliza el modo AUTOCOMMIT para manejar operaciones individuales si es necesario.

