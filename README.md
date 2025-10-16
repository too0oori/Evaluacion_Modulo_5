# Evaluacion_Modulo_5

# 📦 Sistema de Gestión de Inventario

> Proyecto de Base de Datos Relacional desarrollado como parte del Bootcamp de Desarrollo

## Autor

**[Sofía Lagos]**  
Estudiante de Bootcamp de Desarrollo Full Stack Python
---

## Descripción del Proyecto

Sistema de gestión de inventario diseñado para administrar productos, proveedores y transacciones comerciales (compras y ventas) utilizando una base de datos relacional MySQL. El proyecto implementa mejores prácticas de diseño de bases de datos incluyendo normalización hasta 3NF, integridad referencial y transacciones ACID.

---

## Objetivos del Proyecto

- Diseñar un modelo de datos relacional normalizado (3NF)
- Implementar restricciones de integridad referencial
- Crear consultas SQL básicas y complejas
- Manejar transacciones ACID para garantizar consistencia de datos
- Aplicar índices para optimizar el rendimiento de consultas

---

## 🗂️ Estructura de la Base de Datos

### Tablas Principales

#### 📊 **proveedores**
Almacena información de proveedores que suministran productos.
- `id` (PK): Identificador único
- `nombre`: Nombre del proveedor
- `direccion`: Dirección física
- `telefono`: Número de contacto
- `email`: Correo electrónico (UNIQUE)

#### 📦 **productos**
Catálogo de productos disponibles en inventario.
- `id` (PK): Identificador único
- `nombre`: Nombre del producto
- `descripcion`: Descripción detallada
- `precio`: Precio unitario (DECIMAL)
- `stock`: Cantidad disponible
- `proveedor_id` (FK): Referencia a proveedores

#### 💼 **transaccion**
Registro histórico de compras y ventas.
- `id` (PK): Identificador único
- `producto_id` (FK): Referencia a productos
- `tipo`: ENUM('COMPRA', 'VENTA')
- `fecha`: Fecha de la transacción
- `cantidad`: Unidades transaccionadas

---

## 🔄 Proceso de Normalización

### Problema Inicial
El diseño original incluía `proveedor_id` directamente en la tabla `transaccion`, no respetando la **Tercera Forma Normal (3NF)** al crear una dependencia transitiva:

```
transaccion.id → producto_id → proveedor_id (REDUNDANTE ❌)
```

### Solución Implementada
Se eliminó `proveedor_id` de la tabla `transaccion`. Ahora el proveedor se obtiene mediante JOIN:

```sql
SELECT t.*, p.nombre, pr.nombre AS proveedor
FROM transaccion t
JOIN productos p ON t.producto_id = p.id
JOIN proveedores pr ON p.proveedor_id = pr.id;
```

**Beneficios:**
- ✅ Eliminación de redundancia
- ✅ Única fuente de verdad
- ✅ Cumplimiento estricto de 3NF
- ✅ Mayor integridad de datos

---

## 📁 Estructura de Archivos

```
├── tablas_inventario.sql      # Creación de tablas e inserción de datos
├── consultas_basicas.sql      # Consultas SELECT simples
├── consultas_complejas.sql    # JOINs, subconsultas y agregaciones
├── transacciones.sql          # Implementación de transacciones ACID
├── documentacion.txt          # Documentación técnica del proyecto
├── modelo.erd                 # Diagrama Entidad-Relación
├── relacional.drawio          # Diagrama del Modelo Relacional
└── README.md                  # Este archivo
```

---

## 🚀 Instalación y Uso

### Requisitos Previos
- MySQL 5.7+ o MariaDB 10.3+
- Cliente MySQL (MySQL Workbench, DBeaver, o CLI)

---

## 💡 Ejemplos de Consultas

### Productos Disponibles
```sql
SELECT nombre, stock, precio
FROM productos
WHERE stock >= 1;
```

### Ventas Totales por Producto
```sql
SELECT p.nombre, 
       SUM(t.cantidad) AS total_vendido,
       SUM(t.cantidad * p.precio) AS ingresos
FROM productos p
JOIN transaccion t ON p.id = t.producto_id
WHERE t.tipo = 'VENTA'
GROUP BY p.nombre;
```

### Productos Sin Ventas (Subconsulta)
```sql
SELECT p.nombre, p.stock
FROM productos p
WHERE p.id NOT IN (
    SELECT DISTINCT producto_id
    FROM transaccion
    WHERE tipo = 'VENTA'
);
```

---

## 🔐 Características de Seguridad

- **Constraints de validación**: Precio > 0, Stock >= 0
- **Integridad referencial**: Claves foráneas con `ON DELETE RESTRICT`
- **Transacciones ACID**: Uso de `FOR UPDATE` para evitar condiciones de carrera
- **Validación de email**: Constraint CHECK para formato válido

---

## 📊 Optimizaciones

### Índices Implementados
```sql
CREATE INDEX idx_producto_nombre ON productos(nombre);
CREATE INDEX idx_transaccion_fecha ON transaccion(fecha);
CREATE INDEX idx_transaccion_tipo ON transaccion(tipo);
```

Estos índices mejoran significativamente el rendimiento en:
- Búsquedas por nombre de producto
- Consultas filtradas por fecha
- Reportes separados por tipo de transacción

---


## 📄

Este proyecto fue desarrollado con fines educativos como parte del Bootcamp de Desarrollo Full Stack Python x Sofía Lagos :D

---