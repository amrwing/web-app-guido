

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NutriFR</title>

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }        

    </style>

</head>
<body>
    <link rel="stylesheet" href="css\styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

    <div class="texture-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-dark bg-black ">
        <div class="container-fluid align-items-center">
            <a class="navbar-brand" href="index2.php">Nutri<font color="green"><b>FR</b></font></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarScroll">
            <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
                <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="index2.php">Inicio</a>
                </li>
                <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Historial
                </a>
                <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
                    <li><a class="dropdown-item" href="historialimc2.php">IMC</a></li>
                    <li><a class="dropdown-item" href="historialcal2.php">Calorías</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#">Mejoras</a></li>
                </ul>
                </li>
                <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Calculos
                </a>
                <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
                    <li><a class="dropdown-item" href="calculoimc2.php">IMC</a></li>
                    <li><a class="dropdown-item" href="calculocal2.php">Calorías</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#">Mejoras</a></li>
                </ul>
                </li>
                <li class="nav-item">
                <a class="nav-link disabled">Nutriologos (Proximamente)</a>
                </li>
            </ul>
            
                <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
                    <input type="search" class="form-control form-control-dark text-white bg-dark" placeholder="Search..." aria-label="Search">
                </form>

                <div class="flex-shrink-0 dropdown">
                    <a href="#" class="d-block link-light text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="img\profile.png" alt="mdo" width="32" height="32" class="rounded-circle">
                    </a>
                    <ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2">
                        <li><a class="dropdown-item" href="index.php">Cerrar sesión</a></li>
                    </ul>
                </div>
            
            </div>
        </div>
        </nav>
        
        <main>

        <div class="container divc">
            <div class="info">
                <div class="" id="imcform">
                        <form id="formularioimc" method="POST" action="calculocal2.php">
                        <div class="mb-3">
                            <h1>Cálculo de calorías</h1>
                            <label for="sexo" class="form-label">Sexo</label> <br>
                            <select class="form-select" name="sexo">
                                <option>Hombre</option>
                                <option>Mujer</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="peso" class="form-label">Peso (en kilogramos)</label>
                            <input type="number" name="peso" class="form-control" id="peso" required>
                        </div>
                        <div class="mb-3">
                            <label for="actf" class="form-label">Actividad física</label> <br>
                            <select class="form-select" name="actf">
                                <option>Sedentario</option>
                                <option>Actividad ligera</option>
                                <option>Actividad moderada</option>
                                <option>Actividad intensa</option>
                                <option>Actividad muy intensa</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="id" class="form-label">ID</label>
                            <input type="number" name="id" class="form-control" id="id" required>
                        </div>
                        <button type="submit" class="btn btn-primary" name="btnimc" id="imc">Calcular</button>
                    </form>
                </div>
                <br>
                <?php
            
                include('abrirconex.php');

                if (isset($_POST['btnimc'])) {

                    $sexo = $_POST['sexo'];
                    $peso = $_POST['peso'];
                    $actf = $_POST['actf'];
                    $id = $_POST['id'];
                    $fecha = date("d/m/y");
                    $veri1 = "SELECT * FROM datospersonales WHERE ID = '$id'";
                    $verificar1 = mysqli_query($conex, $veri1);

                    if($sexo == "Hombre"){

                        switch($actf){

                            case 'Sedentario':

                                $caltot = (($peso*1*24)*1.2); 
                                $carb = ($caltot/2)/4;
                                $prote = ($caltot*0.15)/4;
                                $grasa = ($caltot*0.35)/9;break;
                            
                            case 'Actividad ligera':

                                $caltot = (($peso*1*24)*1.375);
                                $carb = ($caltot/2)/4; 
                                $prote = ($caltot*0.2)/4;
                                $grasa = ($caltot*0.3)/9;break;
                                
                            case 'Actividad moderada':

                                $caltot = (($peso*1*24)*1.55);
                                $carb = ($caltot/2)/4;
                                $prote = ($caltot*0.25)/4;
                                $grasa = ($caltot*0.25)/9;break;

                            case 'Actividad intensa':

                                $caltot = (($peso*1*24)*1.725);
                                $carb = ($caltot/2)/4;
                                $prote = ($caltot*0.3)/4;
                                $grasa = ($caltot*0.20)/9;break;

                            case 'Actividad muy intensa':

                                $caltot = (($peso*1*24)*1.9);
                                $carb = ($caltot/2)/4;
                                $prote = ($caltot*0.35)/4;
                                $grasa = ($caltot*0.15)/9;break;

                        }

                    }else{
                        switch($actf){

                            case 'Sedentario':

                                $caltot = (($peso*0.9*24)*1.2);
                                $carb = ($caltot/2)/4;
                                $prote = ($caltot*0.15)/4;
                                $grasa = ($caltot*0.35)/9;break;
                            
                            case 'Actividad ligera':

                                $caltot = (($peso*0.9*24)*1.375);
                                $carb = ($caltot/2)/4;
                                $prote = ($caltot*0.2)/4;
                                $grasa = ($caltot*0.3)/9;break;
                                
                            case 'Actividad moderada':

                                $caltot = (($peso*0.9*24)*1.55);
                                $carb = ($caltot/2)/4;
                                $prote = ($caltot*0.25)/4;
                                $grasa = ($caltot*0.25)/9;break;

                            case 'Actividad intensa':

                                $caltot = (($peso*0.9*24)*1.725);
                                $carb = ($caltot/2)/4;
                                $prote = ($caltot*0.3)/4;
                                $grasa = ($caltot*0.20)/9;break;

                            case 'Actividad muy intensa':

                                $caltot = (($peso*0.9*24)*1.9);
                                $carb = ($caltot/2)/4;
                                $prote = ($caltot*0.35)/4;
                                $grasa = ($caltot*0.15)/9;break;

                        }
                    }

                    $regcal = "INSERT INTO calorias(ID, Peso, Sexo, ActividadFisica, Calorias, ProteinasNecesarias, GrasasNecesarias, CarbohidratosNecesarios, Fecha) VALUES ('$id','$peso','$sexo','$actf','$caltot','$prote','$grasa','$carb','$fecha')";

                    $insertar = mysqli_query($conex, $regcal);
                    
                    if($verificar1->num_rows > 0){
                        ?>

                            <table class="table table-success table-striped">
                                <thead>
                                    <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Peso</th>
                                    <th scope="col">Sexo</th>
                                    <th scope="col">Actividad física</th>
                                    <th scope="col">Calorías</th>
                                    <th scope="col">Proteínas necesarias (g)</th>
                                    <th scope="col">Grasas necesarias (g)</th>
                                    <th scope="col">Carbohidratos necesarios (g)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th> <?php echo "$id"; ?></th>
                                        <td> <?php echo "$peso kg"; ?></td>
                                        <td><?php echo "$sexo"; ?></td>
                                        <td><?php echo "$actf"; ?></td>
                                        <td><?php echo "$caltot"; ?></td>
                                        <td><?php echo "$prote"; ?></td>
                                        <td><?php echo "$grasa"; ?></td>
                                        <td><?php echo "$carb"; ?></td>
                                    </tr>
                                </tbody>
                            </table>

                        <?php
                        
                    }else if($verificar1->num_rows == 0){
                            echo "<h4>El ID introducido no existe, intenta de nuevo.</h4>";
                    }
                        

                }

                include('cerrarconex.php');
                
                ?>
            </div>
        </div>
        </main>
        
</body>
</html>