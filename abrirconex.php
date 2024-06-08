<?php

$serv = "localhost";
$user = "root";
$pass = "";
$bd = "nutrifr";

$conex = new mysqli($serv, $user, $pass, $bd);

if($conex->connect_errno){

    echo "Nuestro sitio está experimentando problemas, intente de nuevo por favor.";
    exit();

}


?>