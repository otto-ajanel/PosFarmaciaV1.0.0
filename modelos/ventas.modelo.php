<?php

require_once "conexion.php";

class ModeloVentas
{

	/*
	Elkiminar Detalle de venta

	*/
	static public function eliminarDetalle($tabla, $id)
	{
		$stmt = Conexion::conectar()->prepare(" DELETE from $tabla where CODIGO_VENTA=:ID");
		$stmt->bindParam(":ID", $id, PDO::PARAM_INT);
		if ($stmt->execute()) {
			return "ok";
		} else {
			return "error";
		}
		$stmt->close();
		$stmt = null;
	}

	/*=============================================
	Detalle de Venta
	=============================================*/
	static  public function mdlDetalleVenta($tabla, $valor)
	{
		$stmt = Conexion::conectar()->prepare("select * from $tabla where CODIGO_VENTA= :ID_DETALLE");
		$stmt->bindParam(":ID_DETALLE", $valor, PDO::PARAM_INT);
		if ($stmt->execute()) {
			return $stmt->fetchAll();
		} else {
			return "error";
		}
		$stmt->close();
		$stmt = null;
	}

	/*=============================================
	MOSTRAR VENTAS
	=============================================*/

	static public function mdlMostrarVentas($tabla, $item, $valor)
	{

		if ($item != null) {

			$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE $item = :$item ORDER BY id ASC");

			$stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);

			$stmt->execute();

			return $stmt->fetch();
		} else {

			$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla ORDER BY CODIGO_VENTA ASC");

			$stmt->execute();

			return $stmt->fetchAll();
		}

		$stmt->close();

		$stmt = null;
	}

	/*=============================================
	REGISTRO DE VENTA
	=============================================*/

	static public function mdlIngresarVenta($tabla, $datos)
	{

		$stmt = Conexion::conectar()->prepare("INSERT INTO $tabla(codigo, id_cliente, id_vendedor, productos, impuesto, neto, total, metodo_pago) VALUES (:codigo, :id_cliente, :id_vendedor, :productos, :impuesto, :neto, :total, :metodo_pago)");

		$stmt->bindParam(":codigo", $datos["codigo"], PDO::PARAM_INT);
		$stmt->bindParam(":id_cliente", $datos["id_cliente"], PDO::PARAM_INT);
		$stmt->bindParam(":id_vendedor", $datos["id_vendedor"], PDO::PARAM_INT);
		$stmt->bindParam(":productos", $datos["productos"], PDO::PARAM_STR);
		$stmt->bindParam(":impuesto", $datos["impuesto"], PDO::PARAM_STR);
		$stmt->bindParam(":neto", $datos["neto"], PDO::PARAM_STR);
		$stmt->bindParam(":total", $datos["total"], PDO::PARAM_STR);
		$stmt->bindParam(":metodo_pago", $datos["metodo_pago"], PDO::PARAM_STR);

		if ($stmt->execute()) {

			return "ok";
		} else {

			return "error";
		}

		$stmt->close();
		$stmt = null;
	}
	static public function mdlNuevaVenta($tabla, $datosG)
	{
		$stmt = Conexion::conectar()->prepare(" INSERT INTO $tabla(CODIGO_CLIENTE,CODIGO_USUARIO,NO_FACTURA) VALUES(:CLIENTE,:USUARIO,:NO_FACTURA)");
		$stmt->bindParam(":CLIENTE", $datosG["CODIGO_CLIENTE"], PDO::PARAM_INT);
		$stmt->bindParam(":USUARIO", $datosG["CODIGO_USUARIO"], PDO::PARAM_INT);
		$stmt->bindParam(":NO_FACTURA", $datosG["CODIGO_FACTURA"], PDO::PARAM_INT);
		if ($stmt->execute()) {
			# code...
			return "ok";
		} else {
			return "error";
		}
	}
	static public function mdlNuevoDetalle($tabla, $datosD)
	{

		if ($stmt->execute()) {

			return "ok";
		} else {
			return "error";
		}
	}


	/*=============================================
	EDITAR VENTA
	=============================================*/

	static public function mdlEditarVenta($tabla, $datos)
	{

		$stmt = Conexion::conectar()->prepare("UPDATE $tabla SET  id_cliente = :id_cliente, id_vendedor = :id_vendedor, productos = :productos, impuesto = :impuesto, neto = :neto, total= :total, metodo_pago = :metodo_pago WHERE codigo = :codigo");

		$stmt->bindParam(":codigo", $datos["codigo"], PDO::PARAM_INT);
		$stmt->bindParam(":id_cliente", $datos["id_cliente"], PDO::PARAM_INT);
		$stmt->bindParam(":id_vendedor", $datos["id_vendedor"], PDO::PARAM_INT);
		$stmt->bindParam(":productos", $datos["productos"], PDO::PARAM_STR);
		$stmt->bindParam(":impuesto", $datos["impuesto"], PDO::PARAM_STR);
		$stmt->bindParam(":neto", $datos["neto"], PDO::PARAM_STR);
		$stmt->bindParam(":total", $datos["total"], PDO::PARAM_STR);
		$stmt->bindParam(":metodo_pago", $datos["metodo_pago"], PDO::PARAM_STR);

		if ($stmt->execute()) {

			return "ok";
		} else {

			return "error";
		}

		$stmt->close();
		$stmt = null;
	}

	/*=============================================
	ELIMINAR VENTA
	=============================================*/

	static public function mdlEliminarVenta($tabla, $datos)
	{

		$stmt = Conexion::conectar()->prepare("DELETE FROM $tabla WHERE CODIGO_VENTA = :id");

		$stmt->bindParam(":id", $datos, PDO::PARAM_INT);

		if ($stmt->execute()) {

			return "ok";
		} else {

			return "error";
		}

		$stmt->close();

		$stmt = null;
	}

	/*=============================================
	RANGO FECHAS
	=============================================*/

	static public function mdlRangoFechasVentas($tabla, $fechaInicial, $fechaFinal)
	{

		if ($fechaInicial == null) {

			$stmt = Conexion::conectar()->prepare("SELECT Date_format(FECHA,'%Y/%m')as Fecha,sum(CANTIDAD*PRECIO_VENTA) as Total FROM $tabla V
			INNER JOIN detalle D
			ON D.CODIGO_VENTA=V.CODIGO_VENTA 
			INNER JOIN inventario I 
			ON I.CODIGO_INVENTARIO=D.CODIGO_INVENTARIO
			GROUP BY Date_format(Fecha,'%Y/%m')");

			$stmt->execute();

			return $stmt->fetchAll();
		} else if ($fechaInicial == $fechaFinal) {
			$fechaFinali = $fechaFinal . '%';
			$stmt = Conexion::conectar()->prepare("SELECT Date_format(FECHA,'%Y/%m/%d') as Fecha, sum(CANTIDAD*PRECIO_VENTA) as Total FROM $tabla V
			INNER JOIN detalle D
			ON D.CODIGO_VENTA=V.CODIGO_VENTA
			INNER JOIN inventario I
			ON I.CODIGO_INVENTARIO=D.CODIGO_INVENTARIO			
			WHERE FECHA LIKE :fecha");

			$stmt->bindParam(":fecha", $fechaFinali, PDO::PARAM_STR);

			$stmt->execute();

			return $stmt->fetchAll();
		} else {

			$fechaActual = new DateTime();
			$fechaActual->add(new DateInterval("P1D"));
			$fechaActualMasUno = $fechaActual->format("Y-m-d");

			$fechaFinal2 = new DateTime($fechaFinal);
			$fechaFinal2->add(new DateInterval("P1D"));
			$fechaFinalMasUno = $fechaFinal2->format("Y-m-d");

			if ($fechaFinalMasUno == $fechaActualMasUno) {

				$stmt = Conexion::conectar()->prepare("SELECT date_format(FECHA,'%Y/%m/%d') as Fecha, sum(CANTIDAD*PRECIO_VENTA) as Total FROM $tabla V
				INNER JOIN detalle D
				ON D.CODIGO_VENTA=V.CODIGO_VENTA
				INNER JOIN inventario I
				ON I.CODIGO_INVENTARIO=D.CODIGO_INVENTARIO 
				WHERE fecha BETWEEN '$fechaInicial' AND '$fechaFinalMasUno'
				GROUP BY Date_format(Fecha,'%Y/%m')
				");
			} else {


				$stmt = Conexion::conectar()->prepare("SELECT date_format(FECHA,'%Y/%m/%d') as Fecha, sum(CANTIDAD*PRECIO_VENTA) as Total FROM $tabla V
				INNER JOIN detalle D
				ON D.CODIGO_VENTA=V.CODIGO_VENTA
				INNER JOIN inventario I
				ON I.CODIGO_INVENTARIO=D.CODIGO_INVENTARIO 
				WHERE fecha BETWEEN '$fechaInicial' AND '$fechaFinal'
				GROUP BY Date_format(Fecha,'%Y/%m')
				");
			}

			$stmt->execute();

			return $stmt->fetchAll();
		}
	}

	/*
	Top  de los 10 proiductos mas vendidos 

	
	*/
	static public function mdlVentasProductosTop10($tabla)
	{
		$stmt = Conexion::conectar()->prepare("SELECT P.CODIGO_PRODUCTO,SUM(CANTIDAD) as CANTIDAD,NOMBRE_GENERICO FROM detalle D INNER JOIN inventario I	
ON D.CODIGO_INVENTARIO=I.CODIGO_INVENTARIO
 INNER JOIN producto P
on I.CODIGO_PRODUCTO = P.CODIGO_PRODUCTO
GROUP BY P.CODIGO_PRODUCTO
LIMIT 10 ");
		$stmt->execute();
		return $stmt->fetchAll();
		$stmt->close();
		$stmt = null;
	}


	/*=============================================
	RANGO FECHAS De Venta de productos
	
	=============================================*/

	static public function mdlRangoFechasVentasProductos($tabla, $fechaInicial, $fechaFinal)
	{

		if ($fechaInicial == null) {

			$stmt = Conexion::conectar()->prepare("SELECT Date_format(FECHA,'%Y/%m')as Fecha,sum(CANTIDAD*PRECIO_VENTA) as Total FROM $tabla V
			INNER JOIN detalle D
			ON D.CODIGO_VENTA=V.CODIGO_VENTA 
			INNER JOIN inventario I 
			ON I.CODIGO_INVENTARIO=D.CODIGO_INVENTARIO
			GROUP BY Date_format(Fecha,'%Y/%m')");

			$stmt->execute();

			return $stmt->fetchAll();
		} else if ($fechaInicial == $fechaFinal) {
			$fechaFinali = $fechaFinal . '%';
			$stmt = Conexion::conectar()->prepare("SELECT Date_format(FECHA,'%Y/%m/%d') as Fecha, sum(CANTIDAD*PRECIO_VENTA) as Total FROM $tabla V
			INNER JOIN detalle D
			ON D.CODIGO_VENTA=V.CODIGO_VENTA
			INNER JOIN inventario I
			ON I.CODIGO_INVENTARIO=D.CODIGO_INVENTARIO			
			WHERE FECHA LIKE :fecha");

			$stmt->bindParam(":fecha", $fechaFinali, PDO::PARAM_STR);

			$stmt->execute();

			return $stmt->fetchAll();
		} else {

			$fechaActual = new DateTime();
			$fechaActual->add(new DateInterval("P1D"));
			$fechaActualMasUno = $fechaActual->format("Y-m-d");

			$fechaFinal2 = new DateTime($fechaFinal);
			$fechaFinal2->add(new DateInterval("P1D"));
			$fechaFinalMasUno = $fechaFinal2->format("Y-m-d");

			if ($fechaFinalMasUno == $fechaActualMasUno) {

				$stmt = Conexion::conectar()->prepare("SELECT date_format(FECHA,'%Y/%m/%d') as Fecha, sum(CANTIDAD*PRECIO_VENTA) as Total FROM $tabla V
				INNER JOIN detalle D
				ON D.CODIGO_VENTA=V.CODIGO_VENTA
				INNER JOIN inventario I
				ON I.CODIGO_INVENTARIO=D.CODIGO_INVENTARIO 
				WHERE fecha BETWEEN '$fechaInicial' AND '$fechaFinalMasUno'
				GROUP BY Date_format(Fecha,'%Y/%m')
				");
			} else {


				$stmt = Conexion::conectar()->prepare("SELECT date_format(FECHA,'%Y/%m/%d') as Fecha, sum(CANTIDAD*PRECIO_VENTA) as Total FROM $tabla V
				INNER JOIN detalle D
				ON D.CODIGO_VENTA=V.CODIGO_VENTA
				INNER JOIN inventario I
				ON I.CODIGO_INVENTARIO=D.CODIGO_INVENTARIO 
				WHERE fecha BETWEEN '$fechaInicial' AND '$fechaFinal'
				GROUP BY Date_format(Fecha,'%Y/%m')
				");
			}

			$stmt->execute();

			return $stmt->fetchAll();
		}
	}
	/*=============================================
	SUMAR EL TOTAL DE VENTAS
	=============================================*/

	static public function mdlSumaTotalVentas($tabla)
	{

		$stmt = Conexion::conectar()->prepare("SELECT SUM(neto) as total FROM $tabla");

		$stmt->execute();

		return $stmt->fetch();

		$stmt->close();

		$stmt = null;
	}
	/* 	OBTENIENDO  LA ULTIMA VENTA   EN LA BASE DE dATOS */
	static public function mdlUltimaVenta($tabla)
	{
		$sql = Conexion::conectar()->prepare("SELECT CODIGO_VENTA, NO_FACTURA,FECHA FROM $tabla  ORDER by FECHA DESC Limit 1");
		$sql->execute();
		return $sql->fetchAll();
		$sql->close();
		$sql = null;
	}

	/**Mostrar Ventas de del dia Actual */
	static public function mdlMostrarVentaHoy($tabla)
	{
		$stmt = Conexion::conectar()->prepare("SELECT V.CODIGO_VENTA, U.NOMBRE,V.CODIGO_VENTA, NO_FACTURA,NOMBRE_CLIENTE,sum(CANTIDAD*PRECIO_VENTA) as Total FROM $tabla V
				INNER JOIN usuario U
				ON U.CODIGO_USUARIO=V.CODIGO_USUARIO
				INNER JOIN cliente C
				ON C.CODIGO_CLIENTE=V.CODIGO_CLIENTE 
				INNER JOIN detalle D
				ON D.CODIGO_VENTA=V.CODIGO_VENTA 
				INNER JOIN inventario I 
				ON I.CODIGO_INVENTARIO=D.CODIGO_INVENTARIO
				where DATE_FORMAT(FECHA, '%Y%c%d')=DATE_FORMAT(now(),'%Y%c%d')
				GROUP BY D.CODIGO_VENTA
		");
		$stmt->execute();
		return $stmt->fetchAll();
		$stmt->close();
		$stmt = null;
	}


	static public function mdlCrearDetalleVenta($tabla, $nVenta, $valor, $cantidad)
	{
		$stmt = Conexion::conectar()->prepare("INSERT INTO $tabla(CODIGO_VENTA,CODIGO_INVENTARIO,CANTIDAD) VALUES(:venta, :inventario, :cantidad)");
		$stmt->bindParam(":venta", $nVenta, PDO::PARAM_INT);
		$stmt->bindParam(":inventario", $valor, PDO::PARAM_INT);
		$stmt->bindParam(":cantidad", $cantidad, PDO::PARAM_INT);

		if ($stmt->execute()) {
			# code...
			return "ok";
		} else {
			# code...
			return "error";
		}

		$stmt->close();
		$stmt = null;
	}
}
