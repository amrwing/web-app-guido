

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
                    <form id="formulariohist" method="POST" action="historialcal2.php">
                        <div class="mb-3">
                            <label for="id" class="form-label">ID</label>
                                <input type="number" name="id" class="form-control" id="id" required>
                        </div>
                        <button type="submit" class="btn btn-primary" name="btnhist" id="hist">Buscar</button>
                    </form>
                </div>
        
        <div class="container divc">
            <div class="info">
            <table class="table table-success table-striped">
            <?php

                include("abrirconex.php");

                if (isset($_POST['btnhist'])){

                $id = $_POST['id'];
                $ver = "SELECT * FROM calorias WHERE ID = '$id'";
                
            ?>
                

            <thead>
                <tr>
                <th scope="col">ID</th>
                <th scope="col">Peso</th>
                <th scope="col">Actividad física</th>
                <th scope="col">Calorías</th>
                <th scope="col">Proteínas necesarias (g)</th>
                <th scope="col">Grasas necesarias (g)</th>
                <th scope="col">Carbohidratos necesarios (g)</th>
                <th scope="col">Fecha</th>
                </tr>
            </thead>
            <tbody>
            <?php
                    $res = mysqli_query($conex, $ver);                

                    while($fila = mysqli_fetch_array($res)){?>    
            <tr>
                    
                    <th scope="row"><?php echo $fila['ID'];?></th>
                    <td><?php echo $fila['Peso'];?></td>
                    <td><?php echo $fila['ActividadFisica'];?></td>
                    <td><?php echo $fila['Calorias'];?></td>
                    <td><?php echo $fila['ProteinasNecesarias'];?></td>
                    <td><?php echo $fila['GrasasNecesarias'];?></td>
                    <td><?php echo $fila['CarbohidratosNecesarios'];?></td>
                    <td><?php echo $fila['Fecha'];?></td>
                    
                </tr>
                <?php
                    }
                    mysqli_free_result($res);
                    }
                    include("cerrarconex.php");
                    ?>
            </tbody>
            
            </table>
            </div>
        </div>
        </div>
    </div>
        </main>
        
</body>
</html>