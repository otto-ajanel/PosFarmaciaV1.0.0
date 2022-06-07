<?php

require_once "../controladores/ventas.controlador.php";
require_once "../modelos/ventas.modelo.php";


class TablaVentas{
	

 	/*=============================================
 	 MOSTRAR LA TABLA DE PRODUCTOS
  	=============================================*/ 

	public function mostrarTablaVentasHoy(){

  		$ventas = ControladorVentas::ctrMostrarVentaHoy();
  		if(count($ventas) == 0){

  			echo '{"data": []}';

		  	return;
  		}	
		
  		$datosJson = '{
		  "data": [';

		  for($i = 0; $i < count($ventas); $i++){
			$botones =  "<div class='btn-group'><button class='btn btn-danger eliminarVenta' idVenta='".$ventas[$i]["CODIGO_VENTA"]."'>Eliminar Venta</button></div>";

		  	$datosJson .='[
			      "'.($i+1).'",
			      
			      "'.$ventas[$i]["NO_FACTURA"].'",
			      "'.$ventas[$i]["NOMBRE"].'",
			      "'.$ventas[$i]["NOMBRE_CLIENTE"].'",
			      "'.$ventas[$i]["Total"].'",
				  "'.$botones.'"
				  
			    ],';

		  }

		  $datosJson = substr($datosJson, 0, -1);

		 $datosJson .=   '] 

		 }';
		
		echo $datosJson;


	}


}

/*=============================================
Mostrar Ventas en la tabla 
=============================================*/ 
$ventasHoy = new TablaVentas();
$ventasHoy->mostrarTablaVentasHoy();