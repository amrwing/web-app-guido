<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrarse</title>
</head>
<body>
    
<link rel="stylesheet" href="css\styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

        <form method="POST" action="registrarse.php">
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

</body>
</html>