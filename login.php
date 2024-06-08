<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Hugo 0.98.0">
        <title>Signin Template · Bootstrap v5.2</title>

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
    <body class="text-center">
        <link href="css\signin.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>


        <main class="form-signin w-100 m-auto">
            <form method="POST" action="login.php">
                <b><font size="70" color="black">Nutri<font color="green"><b>FR</b></font></font></b>
                <h1 class="h3 mb-3 fw-normal">Please sign in</h1>

                <div class="form-floating">
                <input type="text" class="form-control" id="usuario" placeholder="Alejandro" name="usuario" require>
                <label for="floatingInput">Nombre de usuario</label>
                </div>
                <div class="form-floating">
                <input type="password" class="form-control" id="contra" placeholder="Password" name="contra" require>
                <label for="floatingPassword">Contraseña</label>
                </div>

                <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" value="remember-me"> Recuerdame
                </label>
                </div>
                <button class="w-100 btn btn-lg btn-primary" type="submit" name="btnlog">Iniciar sesión</button>
                <p class="mt-5 mb-3 text-muted">&copy; 2022–2022</p>
            </form>
            <a href="index.php"><button class="btn btn-primary" >Regresar</button></a>
        </main>
        
        <?php
            
            include('abrirconex.php');

            if (isset($_POST['btnlog'])) {
                $usuario = $_POST['usuario'];
                $contra = $_POST['contra'];
                $veri1 = "SELECT * FROM datospersonales WHERE Usuario = '$usuario' AND Contraseña = '$contra'";
                $verificar1 = mysqli_query($conex, $veri1);

                if($verificar1->num_rows > 0){

                    header("location:index2.php");

                }else if($verificar1->num_rows == 0){
                        echo "<h4>Usuario o contraseña incorrecta, intenta de nuevo.</h4>";
                }
                    

            }
            
            ?>

            
    </body>
</html>
