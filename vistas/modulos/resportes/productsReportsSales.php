<?php



?>
<div class="box-body bg-gradient-graphyc" id="tableOfSales">
    <div class="box-header text-colours2">
        <i class="fa fa-address-card-o"></i>
        <h3 class="box-title"> Productos más Vendidos</h3>
    </div>
    <table class="table table-bordered table-striped dt-responsive tablas fixed_header" width="100%">
        <thead>
            <tr>
                <th style="width:10px">#</th>
                <th>Nombre genérico</th>

                <th>Cantidad</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $res = ControladorVentas::crtProdcutosMasVendidos();
            foreach ($res as $key => $value) {
                echo '<tr>
                <td>' . ($key + 1) . '</td>
                <td>' . $value["NOMBRE_GENERICO"] . '</td>
                <td>' . $value["CANTIDAD"] . '</td>
                
            </tr>';
            }
            ?>

        </tbody>


    </table>


</div>