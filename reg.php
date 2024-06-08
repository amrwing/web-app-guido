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

        
        <!-- Custom styles for this template -->
        
    </head>
    <body class="text-center">
        <link href="css\signin.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

        <main class="form-signun w-100 m-auto">
            <b><font size="70" color="black">Nutri<font color="green"><b>FR</b></font></font></b>
            <h1 class="h3 mb-3 fw-normal">Please sign un</h1>
            <form method="POST" action="reg.php">
                <div class="mb-3">
                    <label for="usuario" class="form-label">Usuario</label>
                    <input type="text" name="usuario" class="form-control" id="usuario" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" id="email" aria-describedby="emailHelp" required>
                    <div id="emailHelp" class="form-text">Tu email es confidencial, no será compartido con nadie.</div>
                </div>
                <div class="mb-3">
                    <label for="contra" class="form-label">Contraseña</label>
                    <input type="password" name="contra" class="form-control" id="contra" required>
                </div>
                <div class="mb-3">
                    <label for="pais" class="form-label">País de origen</label>
                    <input type="text" name="pais" class="form-control" id="pais" required>
                </div>
                <button type="submit" class="btn btn-primary" name="btnreg">Registrarse</button>
            </form>
            <br>
            <a href="index.php"><button class="btn btn-primary" >Regresar</button></a>

            <?php
                
                include('abrirconex.php');

                if (isset($_POST['btnreg'])) {
                    $usuario = $_POST['usuario'];
                    $email = $_POST['email'];
                    $contra = $_POST['contra'];
                    $pais = $_POST['pais'];
                    $fechareg = date("d/m/y");
                    $veri = "SELECT * FROM datospersonales WHERE Usuario = '$usuario'";
                    $veri1 = "SELECT * FROM datospersonales WHERE Email = '$email'";
                    $reg = "INSERT INTO datospersonales(Usuario, Email, Contraseña, País) VALUES ('$usuario','$email','$contra','$pais')";
                    
                    $verificar = mysqli_query($conex, $veri);
                    $verificar1 = mysqli_query($conex, $veri1);

                    if(($verificar->num_rows == 0) && ($verificar1->num_rows == 0)){

                        $resultado = mysqli_query($conex,$reg);
                        if ($resultado) {

                            echo "<h4>Has sido registradx con éxito.</h4>";
                            $veri2 = "SELECT ID FROM datospersonales WHERE Usuario = '$usuario' AND Contraseña = '$contra'";
                            $verificar2 = mysqli_query($conex, $veri2);
                            $fila = mysqli_fetch_array($verificar2);

                            function function_alert($message) {
                                echo "<script type='text/javascript'>
                                        var answer = window.confirm('$message');
                                        if (answer) {
                                            window.location.href = 'index2.php';
                                        }
                                        else {
                                            //some code
                                        }
                                        </script>";
                            }
                            function_alert("Tu ID es: ". $fila["ID"] );

                            header("location:index2.php");

                        } else {

                            echo "<h4>Ocurrió un error, intenta de nuevo.</h4>";

                        }

                    }else if($verificar->num_rows > 0){
                            echo "<h4>Usuario ya registrado, intenta con otro.</h4>";
                    }else if($verificar1->num_rows > 0){
                            echo "<h4>Email ya registrado, intenta con otro.</h4>";
                    }
                        

                }

                include('cerrarconex.php');
                
                ?>
        </main>


            
    </body>
</html>
