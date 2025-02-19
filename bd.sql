DROP DATABASE if EXISTS rankingdb;
CREATE DATABASE rankingdb;

USE rankingdb;

CREATE TABLE productos(
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR (255)
);

CREATE TABLE precios(
	id_precio INT AUTO_INCREMENT PRIMARY KEY,
	id_producto INT, 
	precio INT,
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto)	
);

CREATE TABLE ranking(
	id_ventas INT AUTO_INCREMENT PRIMARY KEY,
	id_producto INT,
	cantidad INT,
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO productos (nombre) VALUES
('Laptop Dell XPS 15'),
('Smartphone Samsung Galaxy S23'),
('Monitor LG UltraGear 27"'),
('Teclado Mecánico Redragon'),
('Mouse Logitech G Pro'),
('Silla Gamer Corsair T3'),
('Auriculares HyperX Cloud II'),
('Tablet iPad Pro 11"'),
('Smartwatch Apple Watch Series 9'),
('Cámara Sony Alpha A7 III'),
('Consola PlayStation 5'),
('SSD NVMe Samsung 1TB'),
('Impresora HP LaserJet Pro'),
('Router TP-Link AX3000'),
('Tarjeta Gráfica RTX 4070 Ti');

INSERT INTO ranking (id_producto, cantidad) VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0),
(11,0);


INSERT INTO precios (id_producto, precio) VALUES
(1, 2500),
(2, 1200),
(3, 450),
(4, 80),
(5, 100),
(6, 300),
(7, 150),
(8, 900),
(9, 500),
(10, 2000),
(11, 600),
(12, 150),
(13, 250),
(14, 100),
(15, 1200);

UPDATE ranking SET cantidad = cantidad + 5 WHERE id_producto = 1;  -- Producto 1: 5 ventas
UPDATE ranking SET cantidad = cantidad + 3 WHERE id_producto = 2;  -- Producto 2: 3 ventas
UPDATE ranking SET cantidad = cantidad + 7 WHERE id_producto = 3;  -- Producto 3: 7 ventas
UPDATE ranking SET cantidad = cantidad + 2 WHERE id_producto = 4;  -- Producto 4: 2 ventas
UPDATE ranking SET cantidad = cantidad + 8 WHERE id_producto = 5;  -- Producto 5: 8 ventas
UPDATE ranking SET cantidad = cantidad + 6 WHERE id_producto = 6;  -- Producto 6: 6 ventas
UPDATE ranking SET cantidad = cantidad + 4 WHERE id_producto = 7;  -- Producto 7: 4 ventas
UPDATE ranking SET cantidad = cantidad + 9 WHERE id_producto = 8;  -- Producto 8: 9 ventas
UPDATE ranking SET cantidad = cantidad + 1 WHERE id_producto = 9;  -- Producto 9: 1 venta
UPDATE ranking SET cantidad = cantidad + 10 WHERE id_producto = 10; -- Producto 10: 10 ventas


CREATE VIEW vista_productos_precios AS
SELECT 
    p.id_producto, 
    p.nombre, 
    pr.precio
FROM productos p
JOIN precios pr ON p.id_producto = pr.id_producto;

-- Crear la vista
CREATE VIEW vista_ranking_productos AS
SELECT 
    p.id_producto,
    p.nombre,
    pr.precio,
    r.cantidad AS total_ventas
FROM productos p
JOIN ranking r ON p.id_producto = r.id_producto
JOIN precios pr ON p.id_producto = pr.id_producto
ORDER BY r.cantidad DESC;