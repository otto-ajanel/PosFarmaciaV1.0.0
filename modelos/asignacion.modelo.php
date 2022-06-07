<?php
require_once"conexion.php";
class ModeloAsignacion{
    /*
        asignacion de las clasificaaciones de los productos
    */
    static public function mdlAsignarProducto($idProducto,$idClasificacion){
       $stmt=Conexion::conectar()->prepare("INSERT INTO asignacion_clasificacion(CODIGO_PRODUCTO, CODIGO_CLASIFICACION) VALUES(:p, :c)");
       $stmt->bindParam(":p",$idProducto,PDO::PARAM_INT);
       $stmt->bindParam(":c",$idClasificacion,PDO::PARAM_INT);
       if($stmt->execute()){
        return "ok";
    }else{
        return "error";
    }
    $stmt->close();
    $stmt = null;
    }
    static public function mdlMostarclasificaciones($idProducto){
        $db=Conexion::conectar()->prepare("SELECT CLASIFICACION FROM asignacion_clasificacion AC
                                        INNER JOIN clasificacion C ON C.CODIGO_CLASIFICACION=AC.CODIGO_CLASIFICACION
                                        WHERE AC.CODIGO_PRODUCTO=:idProducto"
                                        );
        $db->bindParam(':idProducto',$idProducto,PDO::PARAM_INT);
        if($db->execute()){
        return $db->fetchAll();
        }else{
            return "error";
        }
        $db->close();
        $db=null;
     }

}