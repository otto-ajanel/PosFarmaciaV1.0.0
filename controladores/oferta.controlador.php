<?php

class ControladorOferta{

	/*=============================================
	CREAR TIPO DE PRODUCTO
	=============================================*/

	static public function ctrCrearOferta(){
		//está seteado? o tiene valor? set = asignación
		if(isset($_POST["nuevoDescuento"]) &&
			 isset($_POST["nuevoFechaInicio"]) &&
			 isset($_POST["nuevoFechaFin"])
			){

			if(preg_match('/^[0-9.]+$/', $_POST["nuevoDescuento"])){

				$tabla = "OFERTA";
				$datoCodigoAsignacion = $_POST['nuevoCodigoOferta'];
				$datodescuento = $_POST["nuevoDescuento"];
				$datofechainicial = $_POST["nuevoFechaInicio"];
				$datofechafinal = $_POST["nuevoFechaFin"];

				$respuesta = ModeloOferta::mdlIngresarOferta($tabla, $datoCodigoAsignacion,$datodescuento, $datofechainicial, $datofechafinal);
				if($respuesta == "ok"){
					echo'<script>
					swal({
						  type: "success",
						  title: "El tipo de producto ha sido guardado correctamente",
						  showConfirmButton: true,
						  confirmButtonText: "Cerrar"
						  }).then(function(result){
									if (result.value) {
									window.location = "oferta";
									}
								})
					</script>';
				}
			}else{
				echo'<script>
					swal({
						  type: "error",
						  title: "¡Error, el porcentaje de descuento debe ser un valor numérico!",
						  showConfirmButton: true,
						  confirmButtonText: "Cerrar"
						  }).then(function(result){
							if (result.value) {
							window.location = "oferta";
							}
						})
			  	</script>';
			}
		}
	}

	/*=============================================
	MOSTRAR TIPO DE PRODUCTO
	=============================================*/

	static public function ctrMostrarOferta($item, $valor){
		$tabla = "OFERTA";
		$respuesta = ModeloOferta::mdlMostrarOferta($tabla, $item, $valor);
		return $respuesta;
	}

	/*=============================================
	EDITAR TIPO DE PRODUCTO
	=============================================*/

	static public function ctrEditarOferta(){

		if(isset($_POST["editarDescuento"]) &&
			 isset($_POST["editarFechaInicio"]) &&
			 isset($_POST["editarFechaFin"])
			){

			if(preg_match('/^[0-9.]+$/', $_POST["editarDescuento"])){

				$tabla = "OFERTA";

				$datos = array(
 				 						"CODIGO_PRODUCTO" => $_POST["editarCodigoOferta"],
 										"DESCUENTO" => $_POST["editarDescuento"],
 										"FECHA_INICIO" => $_POST["editarFechaInicio"],
 										"FECHA_FIN" => $_POST["editarFechaFin"],
										"CODIGO_OFERTA"=>$_POST["idOferta"]);

				$respuesta = ModeloOferta::mdlEditarOferta($tabla, $datos);
				if($respuesta == "ok"){

					echo'<script>

					swal({
						  type: "success",
						  title: "El tipo de producto ha sido cambiado correctamente",
						  showConfirmButton: true,
						  confirmButtonText: "Cerrar"
						  }).then(function(result){
									if (result.value) {
									window.location = "oferta";
									}
								})
					</script>';
				}
			}else{

				echo'<script>
					swal({
						  type: "error",
						  title: "¡El tipo de producto no puede ir vacío o llevar caracteres especiales!",
						  showConfirmButton: true,
						  confirmButtonText: "Cerrar"
						  }).then(function(result){
							if (result.value) {
							window.location = "oferta";
							}
						})
			  	</script>';
			}
		}
	}

	/*=============================================
	BORRAR TIPO DE PRODUCTO
	=============================================*/

	static public function ctrBorrarOferta(){

		if(isset($_GET["idOferta"])){

			$tabla ="OFERTA";
			$datos = $_GET["idOferta"];
			$respuesta = ModeloOferta::mdlBorrarOferta($tabla, $datos);

			if($respuesta == "ok"){
				echo'<script>
					swal({
						  type: "success",
						  title: "El tipo de producto ha sido borrado correctamente",
						  showConfirmButton: true,
						  confirmButtonText: "Cerrar"
						  }).then(function(result){
									if (result.value) {

									window.location = "oferta";
									}
								})
					</script>';
			}
		}

	}
}
