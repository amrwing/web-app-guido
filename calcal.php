<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calcula tus calorías y macronutrientes</title>
</head>

<body>
    <link rel="stylesheet" href="css\styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
    <div id="imcform">
            <form id="formularioimc" method="POST" action="calcal.php">
            <div class="mb-3">
                <label for="sexo" class="form-label">Sexo</label> <br>
                <select name="sexo">
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
                <select name="actf">
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

                    <table border="1" align="center">

                        <tr style="font-size: 200%;"><td style="border: 1px;">ID</td><td>Peso</td><td>Sexo</td><td>Actividad física</td><td>Calorías</td><td>Proteinas necesarias (g)</td><td>Grasas necesarias (g)</td><td>Carbohidratos necesarios (g)</td></tr>
                        <tr style="font-size: 200%;"><td><?php echo "$id"; ?></td><td><?php echo "$peso kg"; ?></td><td><?php echo "$sexo"; ?></td><td><?php echo "$actf"; ?></td><td><?php echo "$caltot"; ?></td><td><?php echo "$prote"; ?></td><td><?php echo "$grasa"; ?></td><td><?php echo "$carb"; ?></td></tr>

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