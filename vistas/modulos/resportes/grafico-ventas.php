<?php
if (isset($_GET["fechaInicial"])) {
    # code...
    $fechaInicial = $_GET["fechaInicial"];
    $fechaFinal = $_GET["fechaFinal"];
} else {
    $fechaInicial = null;
    $fechaFinal = null;
}
$res = ControladorVentas::ctrRangoFechasVentas($fechaInicial, $fechaFinal);



?>

<div id="bg-graphic" class="box box-solid  bg-gradient-graphic">
    <div class="box-header">
        <i class="fa fa-th"></i>
        <h3 class="box-title"> Gràfico de Ventas</h3>
    </div>
    <div class="box-doby border-radius-none nuevoGraficoVentas">
        <div class="chart" id="line-chart-ventas" style="height:px;">
            <g class="node" transform="translate(210,330)">

                <foreignObject x="-8" y="-8">

                    <canvas id="canvas" style="width:100%; position:absolute">

                    </canvas>
                </foreignObject>
            </g>
        </div>
    </div>

</div>
<script>
    let chart = new Morris.Line({
        // ID of the element in which to draw the chart.
        element: 'line-chart-ventas',
        resize: true,

        // Chart data records -- each entry in this array corresponds to a point on
        // the chart.
        data: [

            <?php

            if (sizeof($res) === 0 || $res[0]["Fecha"] == NULL) {
                echo "{y:'0',ventas: '0'}";
            } else {
                foreach ($res as $key => $value) {
                    echo "{y:'" . $value["Fecha"] . "',ventas:'" . $value["Total"] . "'},";
                }
            }
            ?>

        ],
        // The name of the data record attribute that contains x-values.
        xkey: 'y',
        // A list of names of data record attributes that contain y-values.
        ykeys: ['ventas'],
        // Labels for the ykeys -- will be displayed when you hover over the
        // chart.
        labels: ['ventas'],
        lineColors: ['#efefef'],
        lineWidth: 2,
        hideHover: 'auto',
        gridTextColor: '#fff',
        gridStrokeWidth: 0.4,
        pointSize: 4,
        pointStrokeColors: ['#efefef'],

        gridLineColor: '#efefef',
        gridTextFamily: 'Open Sans',
        gridTextSize: 10,
        preUnits: 'Q '
    });
</script>