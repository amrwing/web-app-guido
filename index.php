

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


        <nav class="navbar navbar-expand-lg navbar-dark bg-black">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.php">Nutri<font color="green"><b>FR</b></font></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarScroll">
            <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
                <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="index.php">Inicio</a>
                </li>
                <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Historial
                </a>
                <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
                    <li><a class="dropdown-item" href="historialimc.php">IMC</a></li>
                    <li><a class="dropdown-item" href="historialcal.php">Calorías</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#">Mejoras</a></li>
                </ul>
                </li>
                <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Cálculos
                </a>
                <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
                    <li><a class="dropdown-item" href="calculoimc.php">IMC</a></li>
                    <li><a class="dropdown-item" href="calculocal.php">Calorías</a></li>
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

            <div class="text-end">
                <a href="login.php"><button type="button" class="btn btn-outline-light me-2">Login</button></a>
                <a href="reg.php"><button type="button" class="btn btn-outline-success" >Sign-up</button></a>
            </div>
            </div>
        </div>
        </nav>
        
        <main>

            <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-indicators">
                <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="bd-placeholder-img" src="img\FP4.jpg" width="100%">
                    <div class="container">
                    <div class="carousel-caption text-start">
                        <font color="black"><h1> Sé saludable</h1>
                        <p>Lleva tu propio registro</p></font> 
                        <p><a class="btn btn-lg btn-primary" href="login.php">Ingresa ahora</a></p>
                    </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="bd-placeholder-img" src="img\FP5.jpg" width="100%">

                    <div class="container">
                    <div class="carousel-caption">
                        <font color="BLACK"> <h1>Conócete</h1>
                        <p>¿Sabes qué es lo ideal para ti?</p></font>
                        <p><a class="btn btn-lg btn-primary" href="reg.php">Registrate</a></p>
                    </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="bd-placeholder-img" src="img\FP3.jpg" width="100%">
                    <div class="container">
                    <div class="carousel-caption text-end">
                        <font color="black"><h1>Profesionales</h1>
                        <p>Solicita ayuda profesional</p></font> 
                        <p><a class="btn btn-lg btn-primary" href="#">Proximamente </a></p>
                    </div>
                    </div>
                </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Siguiente</span>
                </button>
            </div>

            <br>
            <div class="container marketing">

                <!-- Three columns of text below the carousel -->
                <div class="row">
                <div class="col-lg-4">
                    <img class="bd-placeholder-img rounded-circle" width="140" height="140" src="img\fast.png" focusable="false">
                    <h2 class="fw-normal">Rapidez</h2>
                    <p>Registrate o inicia sesión al instante. Obtén tus propios resultados al instante</p>
                </div><!-- /.col-lg-4 -->
                <div class="col-lg-4">
                    <img class="bd-placeholder-img rounded-circle" width="140" height="140" src="img\seguro.png" focusable="false">
                    <h2 class="fw-normal">Seguridad</h2>
                    <p>Todos tus datos y resultados serán protegidos, jamás compartidos a terceros. </p>
                </div><!-- /.col-lg-4 -->
                <div class="col-lg-4">
                    <img class="bd-placeholder-img rounded-circle" width="140" height="140" src="img\sano.png" focusable="false">
                    <h2 class="fw-normal">Saludable</h2>
                    <p>Datos indispensables para tu salud </p>
                </div><!-- /.col-lg-4 -->
                </div><!-- /.row -->

            </div><!-- /.container -->
            <br>

            <!-- FOOTER -->
            <footer class="container">
                <p class="float-end"><a href="#">Back to top</a></p>
                <p>&copy; 2022–2022 NutriFR, Inc. &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a></p>
            </footer>
            </main>
        
</body>
</html>