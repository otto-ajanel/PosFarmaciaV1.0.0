<div class="content-wrapper">
  <section class="content-header">
    <h1 class="pull-center">
      R e p o r t e s
    </h1>
    <ol class="breadcrumb">
      <li><a href="inicio"><i class="ion-navicon-round"></i>Inicio</a></li>
    </ol>
  </section>
  <section class="content">
    <div class="box">
      <div class="box-header with-border">
        <button type="button" class="btn btn-info" id="daterange-btn2">
          <span>
            <i class="fa fa-calender">
              Rango de Fecha
            </i>
          </span>
        </button>
        <button type="button" class="btn btn-danger" id="btn-report-pdf">
          <span>
            <i class="fa fa-file-pdf-o">
              Exportar
            </i>
          </span>
        </button>        
      </div>
      <div class="box-body">
          <div class="row">
            <div class="col-xs-6">
              <?php
               include "resportes/grafico-ventas.php";
              ?>
            </div>
            <div class="col-xs-6">
              <?php
               include "resportes/productsReportsSales.php";
              ?>
            </div>
          </div>
        
      </div>
     </div>
  </section>
</div>