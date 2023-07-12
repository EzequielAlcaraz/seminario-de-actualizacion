<?php
// Configuración de la conexión a la base de datos
$host = "localhost";
$dbname = "nombre_de_la_base_de_datos";
$username = "root";
$password = "1234";

try {
  // Crear una nueva instancia de conexión a la base de datos
  $connection = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
  $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  // Obtener el ID del usuario a través del método POST
  $data = json_decode(file_get_contents('php://input'));
  $usuario_id = $data->id;

  // Llamar al procedimiento almacenado utilizando una consulta preparada
  $sql = "CALL ObtenerUsuarioPorId(?)";
  $stmt = $connection->prepare($sql);
  $stmt->bindParam(1, $usuario_id, PDO::PARAM_INT);
  $stmt->execute();

  // Obtener los resultados
  $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

  // Cerrar la conexión a la base de datos
  $connection = null;

  // Devolver los resultados en formato JSON
  header('Content-Type: application/json');
  echo json_encode($results);
} catch (PDOException $e) {
  echo "Error: " . $e->getMessage();
}
?>
