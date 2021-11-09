-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-09-2021 a las 01:38:39
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;



-- BASE DE DATOS: `NISSI`


CREATE TABLE `CLIENTE` (
  `CODIGO_CLIENTE` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primari del cliente, identificador único',
  `NIT` VARCHAR(20) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nit del cliente',
  `NOMBRE_CLIENTE` VARCHAR(50) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nombre del cliente',
  `DIRECCION` VARCHAR(50) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Dirección para la factura del cliente',
  `VISIBLE` INT(1) NOT NULL DEFAULT '1' COMMENT 'Estado del cliente, activo = 1, desactivo = 0',
  PRIMARY KEY (`CODIGO_CLIENTE`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;


/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `CONTACTO_CLIENTE` (
  `CODIGO_CONTACTO_C` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria del contacto del cliente, identificador único',
  `CODIGO_CLIENTE` INT(11) NOT NULL COMMENT 'Clave secundaria de la tabla cliente, para identificar al cliente',
  `TELEFONO` INT(10) NOT NULL COMMENT 'Número de teléfono del cliente',
  PRIMARY KEY (`CODIGO_CONTACTO_C`),
  FOREIGN KEY (`CODIGO_CLIENTE`) REFERENCES `CLIENTE` (`CODIGO_CLIENTE`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;

/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `PROVEEDOR` (
  `CODIGO_PROVEEDOR` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria del proveedor, identificador único',
  `NIT` VARCHAR(20) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nit del proveedor',
  `NOMBRE_PROVEEDOR` VARCHAR(100) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nombre del proveedor',
  `DIRECCION` VARCHAR(100) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Dirección del proveedor',
  `VISIBLE` INT(1) NOT NULL DEFAULT '1' COMMENT 'Estado del proveedor, activo = 1, desactivo = 0',
  PRIMARY KEY (`CODIGO_PROVEEDOR`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;

/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `CONTACTO_PROVEEDOR` (
  `CODIGO_CONTACTO_P` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria del contacto del proveedor, identificador único',
  `CODIGO_PROVEEDOR` INT(11) NOT NULL COMMENT 'Clave secundaria de la tabla proveedor, para identificar al proveedor',
  `TELEFONO` INT(10) NOT NULL COMMENT 'Número de teléfono del proveedor',
  PRIMARY KEY (`CODIGO_CONTACTO_P`),
  FOREIGN KEY (`CODIGO_PROVEEDOR`) REFERENCES `PROVEEDOR` (`CODIGO_PROVEEDOR`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;

/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `PRODUCTO` (
  `CODIGO_PRODUCTO` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria del producto, identificador único',
  `NOMBRE_GENERICO` VARCHAR(50) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nombre genérico del producto ingresado',
  `NOMBRE_COMERCIAL` VARCHAR(50) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nombre comercial del producto ingresado',
  `STOCK_MIN` INT(10) NOT NULL COMMENT 'Indicador de la cantidad mínima que debe de haber de producto',
  `STOCK_MAX` INT(10) NOT NULL COMMENT 'Indicador de la cantidad máxima que debe de haber de producto',
  `VISIBLE` INT(1) NOT NULL DEFAULT '1' COMMENT 'Estado del producto, activo = 1, desactivo = 0',
  PRIMARY KEY (`CODIGO_PRODUCTO`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;


/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `PRESENTACION` (
  `CODIGO_PRESENTACION` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de la presentación del producto, identificador único',
  `PRESENTACION` VARCHAR(25) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nombre de la presentación del producto, ejemplo: tableta',
  `VISIBLE` INT(1) NOT NULL DEFAULT '1' COMMENT 'Estado de la presentación del producto, activo = 1, desactivo = 0',
  PRIMARY KEY (`CODIGO_PRESENTACION`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;

/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `CLASIFICACION` (
  `CODIGO_CLASIFICACION` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de la clasificación del producto, identificador único',
  `CLASIFICACION` VARCHAR(25) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nombre de la clasificación del producto, ejemplo: Analgésico',
  `VISIBLE` INT(1) NOT NULL DEFAULT '1' COMMENT 'Estado de la clasificación del producto, activo = 1, desactivo = 0',
  PRIMARY KEY (`CODIGO_CLASIFICACION`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;

/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `TIPO_PRODUCTO` (
  `CODIGO_TIPO` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria del tipo de producto, identificador único',
  `TIPO_PRODUCTO` VARCHAR(25) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nombre del tipo de producto, puede ser producto de marca o producto genérico',
  `VISIBLE` INT(1) COLLATE UTF8_SPANISH_CI NOT NULL DEFAULT '1' COMMENT 'Estado del tipo de producto, activo = 1, desactivo = 0',
  PRIMARY KEY (`CODIGO_TIPO`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;

/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `ASIGNACION_PRODUCTO` (
  `CODIGO_ASIGNACION` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria para la asignación de producto, identificador único',
  `CODIGO_PRODUCTO` INT(11) NOT NULL COMMENT 'Clave secundaria para la identificación del producto',
  `CODIGO_PRESENTACION` INT(11) NOT NULL COMMENT 'Clave secundaria para la identificación de la presentación del producto',
  `CODIGO_TIPO` INT(11) NOT NULL COMMENT 'Clave secundaria para la identifación del tipo de producto',
  `CODIGO_CLASIFICACION` INT(11) NOT NULL COMMENT 'Clave secundaria para la identificación de la clasificación del producto',  
  PRIMARY KEY (`CODIGO_ASIGNACION`),
  FOREIGN KEY (`CODIGO_PRODUCTO`) REFERENCES `PRODUCTO` (`CODIGO_PRODUCTO`),
  FOREIGN KEY (`CODIGO_PRESENTACION`) REFERENCES `PRESENTACION` (`CODIGO_PRESENTACION`),
  FOREIGN KEY (`CODIGO_CLASIFICACION`) REFERENCES `CLASIFICACION` (`CODIGO_CLASIFICACION`),
  FOREIGN KEY (`CODIGO_TIPO`) REFERENCES `TIPO_PRODUCTO` (`CODIGO_TIPO`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;


/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `OFERTA` (
  `CODIGO_OFERTA` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria para la oferta, identificador único',
  `CODIGO_ASIGNACION` INT(11) NOT NULL COMMENT 'Clava secundaria para la asignación del producto en oferta',
  `DESCUENTO` DOUBLE(10,2) NOT NULL COMMENT 'El porcentaje de descuento que se asignará al producto',
  `FECHA_INICIO` DATE NOT NULL COMMENT 'Fecha en la que inicia la oferta',
  `FECHA_FIN` DATE NOT NULL COMMENT 'Fecha en la que finaliza la oferta',
  PRIMARY KEY (`CODIGO_OFERTA`),
  FOREIGN KEY (`CODIGO_ASIGNACION`) REFERENCES `ASIGNACION_PRODUCTO` (`CODIGO_ASIGNACION`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;


/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `PEDIDO` (
  `NO_ORDEN` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria para distinguir los pedidos, identificador único',
  `CODIGO_PROVEEDOR` INT(11) NOT NULL COMMENT 'Clave secundaria para identificar el proveedor a quien se hará el pedido',
  `FECHA_PEDIDO` DATE NOT NULL COMMENT 'Fecha en la que se está haciendo el pedido',
  `FECHA_ESTIMADA` DATE NOT NULL COMMENT 'Fecha que se estima que llegará el producto',
  PRIMARY KEY (`NO_ORDEN`), 
  FOREIGN KEY (`CODIGO_PROVEEDOR`) REFERENCES `PROVEEDOR` (`CODIGO_PROVEEDOR`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;


/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `PEDIDO_PRODUCTO` (
  `CODIGO_PP` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria para identificar el pedido y los productos, identificador único',
  `NO_ORDEN` INT(11) NOT NULL COMMENT 'Clave secundara para identificar el pedido',
  `CODIGO_ASIGNACION` INT(11) NOT NULL COMMENT 'Clave secundaria para identificar la asignación del producto',
  `CANTIDAD` INT(10) NOT NULL COMMENT 'Cantidad del producto que se pedirá al proveedor',
  `PRECIO_UNITARIO` DOUBLE(10,2) NOT NULL COMMENT 'Precio unitario del producto',
  PRIMARY KEY (`CODIGO_PP`),
  FOREIGN KEY (`NO_ORDEN`) REFERENCES `PEDIDO` (`NO_ORDEN`),
  FOREIGN KEY (`CODIGO_ASIGNACION`) REFERENCES `ASIGNACION_PRODUCTO` (`CODIGO_ASIGNACION`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;

/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `ROL` (
  `CODIGO_ROL` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria para los roles que existiran en el sistema, identificador único',
  `ROL` VARCHAR(25) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Rol que existirá en el sistema ejemplo: administrador, vendedor, entre otros',
  PRIMARY KEY (`CODIGO_ROL`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;

INSERT INTO `ROL` (`CODIGO_ROL`, `ROL`) VALUES
(1, 'ESPECIAL'),
(2, 'ADMINISTRADOR'),
(3, 'VENDEDOR');

/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `USUARIO` (
  `CODIGO_USUARIO` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria para el usuario, identificador único',
  `CODIGO_ROL` INT(11) NOT NULL COMMENT 'Clave secundaria para identificar el rol',
  `NOMBRE` VARCHAR(25) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nombre de la persona que trabajará en la farmacia',
  `USUARIO` VARCHAR(25) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Nombre de usuario que identifique a la persona para iniciar sesión en el sistema',
  `CONTRASEÑA` VARCHAR(75) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'Contraseña para iniciar sesión en el sistema',
  `URL` VARCHAR(70) COLLATE UTF8_SPANISH_CI NOT NULL COMMENT 'dirección para la imagen que identifique al usuario',
  `ESTADO` INT(2) NOT NULL COMMENT 'Estado del usuario, Activo = 1, desactivo = 0',
  PRIMARY KEY (`CODIGO_USUARIO`),
  FOREIGN KEY (`CODIGO_ROL`) REFERENCES `ROL` (`CODIGO_ROL`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;


INSERT INTO `usuario` (`CODIGO_USUARIO`, `CODIGO_ROL`, `NOMBRE`, `USUARIO`, `CONTRASEÑA`, `URL`, `ESTADO`) VALUES
(1, 2, 'admin', 'admin', '$2a$07$asxx54ahjppf45sd87a5auXBm1Vr2M1NV5t/zNQtGHGpS5fFirrbG', '', 1),
(2, 1, 'AJANEL', 'OTTO', '$2a$07$asxx54ahjppf45sd87a5auVODg.uIPbQ5WGDLMcBmmxyGgh4PRboy', 'vistas/img/usuarios/OTTO/462.png', 1);

/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `VENTA` (
  `CODIGO_VENTA` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria para identificar las ventas realizadas, identificador único',
  `CODIGO_CLIENTE` INT(11) NOT NULL COMMENT 'Clave secundaria para identificar al cliente al cual le corresponde la venta',
  `CODIGO_USUARIO` INT(11) NOT NULL COMMENT 'Clave secundaria para identificar que usuario realizó la venta',
  `NO_FACTURA` INT(11) NOT NULL COMMENT 'Número de factura para identificar la venta.',
  `FECHA` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Lleva el control de la fecha de venta',
  PRIMARY KEY (`CODIGO_VENTA`),
  FOREIGN KEY (`CODIGO_CLIENTE`) REFERENCES `CLIENTE` (`CODIGO_CLIENTE`),
  FOREIGN KEY (`CODIGO_USUARIO`) REFERENCES `USUARIO` (`CODIGO_USUARIO`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;





INSERT INTO `venta` (`CODIGO_VENTA`, `CODIGO_CLIENTE`, `CODIGO_USUARIO`, `NO_FACTURA`, `FECHA`) VALUES
(1, 1, 6, 1, '2021-10-15 04:33:53'),
(21, 5, 6, 2, '2021-10-20 05:34:22'),
(23, 11111111, 6, 3, '2021-10-20 05:37:03'),
(24, 11111111, 6, 4, '2021-10-20 05:38:26'),
(25, 11111111, 6, 5, '2021-10-20 05:38:30'),
(26, 11111111, 2, 6, '2021-10-22 05:28:19'),
(27, 11111111, 2, 7, '2021-10-22 20:28:38'),
(28, 11111111, 2, 8, '2021-10-23 04:03:06'),
(29, 11111111, 2, 9, '2021-10-23 04:25:22'),
(30, 11111111, 2, 10, '2021-10-23 04:26:04'),
(31, 11111111, 2, 11, '2021-10-23 04:26:47'),
(32, 11111111, 2, 12, '2021-10-23 04:28:41'),
(33, 11111111, 2, 13, '2021-10-23 04:29:03'),
(34, 11111111, 2, 14, '2021-10-23 04:29:31'),
(35, 11111111, 2, 15, '2021-10-23 04:30:23'),
(36, 11111111, 2, 16, '2021-10-23 04:31:01'),
(37, 11111111, 2, 17, '2021-10-23 04:31:03'),
(38, 11111111, 2, 18, '2021-10-23 04:31:20'),
(39, 11111111, 2, 19, '2021-10-23 04:31:39'),
(40, 11111111, 2, 20, '2021-10-23 04:31:41'),
(41, 11111111, 2, 21, '2021-10-23 04:31:42'),
(42, 11111111, 2, 22, '2021-10-23 04:32:11'),
(43, 11111111, 2, 23, '2021-10-23 04:32:26'),
(44, 11111111, 2, 24, '2021-10-23 04:37:02'),
(46, 11111111, 2, 26, '2021-10-23 05:21:51'),
(47, 11111111, 2, 27, '2021-10-23 05:23:26'),
(48, 11111111, 2, 28, '2021-10-23 05:24:21'),
(49, 11111111, 2, 29, '2021-10-23 05:29:28'),
(50, 11111111, 2, 30, '2021-10-23 05:30:41'),
(51, 11111111, 2, 31, '2021-10-23 05:31:10'),
(52, 11111111, 2, 32, '2021-10-23 05:31:37'),
(53, 11111111, 2, 33, '2021-10-23 05:34:01'),
(54, 5, 2, 34, '2021-10-23 05:34:26'),
(55, 11111111, 2, 35, '2021-10-23 05:34:41'),
(56, 11111111, 2, 36, '2021-10-23 05:37:59'),
(57, 11111111, 2, 37, '2021-10-23 05:38:11'),
(58, 11111111, 2, 38, '2021-10-23 05:38:20'),
(59, 11111111, 2, 39, '2021-10-23 05:38:46'),
(60, 11111111, 2, 40, '2021-10-23 05:38:48'),
(61, 11111111, 2, 41, '2021-10-23 05:38:49'),
(62, 11111111, 2, 42, '2021-10-23 05:38:49'),
(63, 11111111, 2, 42, '2021-10-23 05:38:50'),
(64, 11111111, 2, 43, '2021-10-23 05:38:50'),
(65, 11111111, 2, 44, '2021-10-23 05:38:50'),
(66, 11111111, 2, 45, '2021-10-23 05:38:50'),
(67, 11111111, 2, 46, '2021-10-23 05:38:51'),
(68, 11111111, 2, 47, '2021-10-23 05:38:51'),
(69, 11111111, 2, 47, '2021-10-23 05:38:51'),
(70, 11111111, 2, 47, '2021-10-23 05:38:51'),
(71, 11111111, 2, 47, '2021-10-23 05:38:51'),
(72, 11111111, 2, 47, '2021-10-23 05:38:52'),
(73, 11111111, 2, 48, '2021-10-23 05:38:52'),
(74, 11111111, 2, 49, '2021-10-23 05:38:52'),
(75, 11111111, 2, 50, '2021-10-23 05:38:52'),
(76, 11111111, 2, 51, '2021-10-23 05:38:53'),
(77, 11111111, 2, 52, '2021-10-23 05:38:53'),
(78, 11111111, 2, 52, '2021-10-23 05:38:53'),
(79, 11111111, 2, 52, '2021-10-23 05:38:54'),
(80, 11111111, 2, 53, '2021-10-23 05:38:54'),
(81, 11111111, 2, 54, '2021-10-23 05:38:55'),
(82, 11111111, 2, 55, '2021-10-23 05:38:55'),
(83, 11111111, 2, 55, '2021-10-23 05:39:35'),
(84, 11111111, 2, 56, '2021-10-23 05:40:29'),
(85, 11111111, 2, 57, '2021-10-23 05:40:48'),
(86, 11111111, 2, 58, '2021-10-23 05:40:49'),
(87, 11111111, 2, 59, '2021-10-23 05:40:51'),
(88, 11111111, 2, 60, '2021-10-23 05:40:53'),
(89, 11111111, 2, 61, '2021-10-23 05:41:01'),
(90, 11111111, 2, 62, '2021-10-23 05:41:03'),
(91, 11111111, 2, 63, '2021-10-23 05:41:06'),
(92, 11111111, 2, 64, '2021-10-23 05:45:42'),
(93, 11111111, 2, 65, '2021-10-23 05:53:07'),
(94, 11111111, 2, 66, '2021-10-23 05:53:46'),
(95, 11111111, 2, 67, '2021-10-23 05:57:56'),
(96, 11111111, 2, 68, '2021-10-23 05:59:07'),
(97, 11111111, 2, 69, '2021-10-23 06:01:28'),
(98, 11111111, 2, 70, '2021-10-23 06:01:34'),
(99, 11111111, 2, 71, '2021-10-23 06:05:12'),
(100, 11111111, 2, 72, '2021-10-23 16:11:19'),
(101, 11111111, 2, 73, '2021-10-23 18:12:17'),
(102, 11111111, 2, 74, '2021-10-23 18:20:22'),
(103, 11111111, 2, 75, '2021-10-23 18:35:33'),
(104, 11111111, 2, 76, '2021-10-23 21:32:36'),
(105, 11111111, 2, 77, '2021-10-23 21:51:32'),
(106, 11111111, 2, 78, '2021-10-23 21:54:12'),
(107, 11, 2, 79, '2021-10-23 22:20:19'),
(108, 5, 2, 80, '2021-10-23 22:23:30'),
(109, 11111111, 2, 81, '2021-10-24 01:09:16'),
(110, 11111111, 2, 82, '2021-10-24 01:18:35'),
(111, 11111111, 2, 83, '2021-10-24 01:26:15'),
(112, 1, 2, 84, '2021-10-24 01:31:11'),
(113, 11111111, 2, 85, '2021-10-24 06:09:40'),
(114, 1, 2, 86, '2021-10-24 17:50:36'),
(115, 11111111, 2, 87, '2021-10-25 19:49:51'),
(116, 11111111, 2, 88, '2021-10-25 20:06:57'),
(117, 1, 2, 89, '2021-10-31 07:00:46'),
(118, 11111111, 2, 90, '2021-10-31 07:01:18'),
(119, 11111111, 2, 91, '2021-10-31 07:10:54'),
(120, 11111111, 2, 92, '2021-10-31 07:12:35');








/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE `INVENTARIO`(
	`CODIGO_INVENTARIO` INT (11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria para identificar el inventario, identificador único',
	`CODIGO_BARRAS` INT (11) NOT NULL COMMENT 'Codigo de barra para identificar el producto', 
	`FECHA_INGRESO` DATE NOT NULL COMMENT 'Fecha de ingreso del producto a la farmacia', 
	`CADUCIDAD` DATE NOT NULL COMMENT 'Fecha de vencimiento del producto', 
	`PRECIO_COMPRA` FLOAT(10,2) NOT NULL COMMENT 'Precio a como se compró el producto',
	`PRECIO_VENTA` FLOAT(10,2) NOT NULL COMMENT 'Precio a como se venderá el producto', 
	`CANTIDAD_PRODUCTO` INT(11) NOT NULL COMMENT 'Cantidad total de producto disponible', 
	`CODIGO_ASIGNACION` INT(11) NOT NULL COMMENT 'Clave secundaria para identificar la asignación de producto',
	`CODIGO_PROVEEDOR` INT(11) NOT NULL COMMENT 'Clave secundaria para identificar al proveedor',
	PRIMARY KEY (`CODIGO_INVENTARIO`),
	FOREIGN KEY (`CODIGO_ASIGNACION`) REFERENCES `ASIGNACION_PRODUCTO` (`CODIGO_ASIGNACION`),
	FOREIGN KEY (`CODIGO_PROVEEDOR`) REFERENCES `PROVEEDOR` (`CODIGO_PROVEEDOR`)
)ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;

/*-------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE DETALLE_INVENTARIO (
	`CODIGO_DETALLE` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria para identificar el detalle de inventario, identificador único',
	`CODIGO_VENTA` INT(11) NOT NULL COMMENT 'Clave secundaria para identificar la venta que se está realizando', 
	`CODIGO_INVENTARIO` INT(11) NOT NULL COMMENT 'Clave secundaria para identificar el producto que se encuentra en inventario y póder descontarlo del inventario al hacer la venta',
	PRIMARY KEY (`CODIGO_DETALLE`),
	FOREIGN KEY (`CODIGO_VENTA`) REFERENCES `VENTA` (`CODIGO_VENTA`),
	FOREIGN KEY (`CODIGO_INVENTARIO`) REFERENCES `INVENTARIO` (`CODIGO_INVENTARIO`)
)ENGINE=INNODB DEFAULT CHARSET=UTF8 COLLATE=UTF8_SPANISH_CI;

/*-------------------------------------------------------------------------------------------------------------------------*/

INSERT INTO INVENTARIO (CODIGO_INVENTARIO, CODIGO_BARRAS, FECHA_INGRESO, CADUCIDAD, PRECIO_COMPRA, PRECIO_VENTA, CANTIDAD_PRODUCTO, CODIGO_ASIGNACION, CODIGO_PROVEEDOR) 
VALUE (1, 123456, TR_TO_DATE('2021-10-01','%Y-%m-%d'), STR_TO_DATE('2021-10-25','%Y-%m-%d'), 10.00, 12.00, 5, 1, 1);
INSERT INTO INVENTARIO (CODIGO_INVENTARIO, CODIGO_BARRAS, FECHA_INGRESO, CADUCIDAD, PRECIO_COMPRA, PRECIO_VENTA, CANTIDAD_PRODUCTO, CODIGO_ASIGNACION, CODIGO_PROVEEDOR) 
VALUE (2, 125286, TR_TO_DATE('2021-10-24','%Y-%m-%d'), STR_TO_DATE('2021-10-31','%Y-%m-%d'), 15.00, 18.00, 10, 2, 2);

INSERT INTO INVENTARIO (CODIGO_INVENTARIO, CODIGO_BARRAS, FECHA_INGRESO, CADUCIDAD, PRECIO_COMPRA, PRECIO_VENTA, CANTIDAD_PRODUCTO, CODIGO_ASIGNACION, CODIGO_PROVEEDOR) 
VALUE (3, 985632, STR_TO_DATE('2021-10-02','%Y-%m-%d'), STR_TO_DATE('2021-11-02','%Y-%m-%d'), 14.00, 20.00, 10, 3, 3);






COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;