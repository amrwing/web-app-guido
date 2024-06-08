<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calcula tu IMC</title>
</head>

<body>
    <link rel="stylesheet" href="css\styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
    <div id="imcform">
            <form id="formularioimc" method="POST" action="calimc.php">
            <div class="mb-3">
                <label for="estatura" class="form-label">Estatura (en centímetros)</label>
                <input type="number" name="estatura" class="form-control" id="estatura" required>
            </div>
            <div class="mb-3">
                <label for="peso" class="form-label">Peso (en kilogramos)</label>
                <input type="number" name="peso" class="form-control" id="peso" required>
            </div>
            <div class="mb-3">
                <label for="id" class="form-label">ID</label>
                <input type="number" name="id" class="form-control" id="id" required>
            </div>
            <button type="submit" class="btn btn-primary" name="btnimc" id="imc">Calcular</button>
        </form>
    </div>
        <?php
            
            include('abrirconex.php');

            if (isset($_POST['btnimc'])) {

                $est = $_POST['estatura'];
                $peso = $_POST['peso'];
                $id = $_POST['id'];
                $fecha = date("d/m/y");
                $veri1 = "SELECT * FROM datospersonales WHERE ID = '$id'";
                $verificar1 = mysqli_query($conex, $veri1);

                $res = $peso/(($est*$est)/10000);

                $imc = bcdiv($res, '1', 1); 

                $regimc = "INSERT INTO imc(ID, Peso, Estatura, IMC, Fecha) VALUES ('$id','$peso','$est','$imc','$fecha')";

                $insertar = mysqli_query($conex, $regimc);

                if($verificar1->num_rows > 0){
                    ?>

                    <table border="1" align="center">

                        <tr style="font-size: 200%;"><td style="border: 1px;">ID</td><td>Peso</td><td>Estatura</td><td>IMC</td></tr>
                        <tr style="font-size: 200%;"><td><?php echo "$id"; ?></td><td><?php echo "$peso kg"; ?></td><td><?php echo "$est cm"; ?></td><td><?php echo "$imc"; ?></td></tr>

                    </table>

                    <?php
                    
                }else if($verificar1->num_rows == 0){
                        echo "<h4>El ID introducido no existe, intenta de nuevo.</h4>";
                }
                    

            }

            include('cerrarconex.php');
            
            ?>

</body>
</html>