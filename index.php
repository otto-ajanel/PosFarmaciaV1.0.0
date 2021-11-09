<?php

require_once "controladores/plantilla.controlador.php";
require_once "controladores/usuarios.controlador.php";
require_once "controladores/clasificacion.controlador.php";
require_once "controladores/presentacion.controlador.php";
require_once "controladores/tipoproducto.controlador.php";
require_once "controladores/proveedor.controlador.php";
require_once "controladores/producto.controlador.php";
require_once "controladores/cliente.controlador.php";
require_once "controladores/ventas.controlador.php";
require_once "controladores/pedido.controlador.php";

require_once "controladores/stock.controlador.php";
require_once "controladores/caducidad.controlador.php";

require_once "controladores/inventario.controlador.php";

require_once "controladores/oferta.controlador.php";
require_once "controladores/productosofertas.controlador.php";


require_once "modelos/usuarios.modelo.php";
require_once "modelos/clasificacion.modelo.php";
require_once "modelos/presentacion.modelo.php";
require_once "modelos/tipoproducto.modelo.php";
require_once "modelos/proveedor.modelo.php";
require_once "modelos/producto.modelo.php";
require_once "modelos/cliente.modelo.php";
require_once "modelos/ventas.modelo.php";
require_once "modelos/pedido.modelo.php";

require_once "modelos/stock.modelo.php";
require_once "modelos/caducidad.modelo.php";

require_once "modelos/inventario.modelo.php";

require_once "extensiones/vendor/autoload.php";

require_once "modelos/productosofertas.modelo.php";
require_once "modelos/oferta.modelo.php";
require_once "extensiones/vendor/autoload.php";

$plantilla = new ControladorPlantilla();

$plantilla -> ctrPlantilla();
