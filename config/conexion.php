<?php
// Cargar Configuraciones
$config = require_once 'config.php'; // Carga el archivo de configuración que contiene las credenciales de la base de datos

try {
    // Conexión a PostgreSQL utilizando PDO
    $dsn = "pgsql:host={$config['db_host']};port={$config['db_port']};dbname={$config['db_name']};";
    // Crea una nueva instancia de PDO con la configuración de la base de datos
    $pdo = new PDO($dsn, $config['db_user'], $config['db_password'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, // Configura PDO para lanzar excepciones en caso de error
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC // Configura PDO para devolver resultados como arrays asociativos por defecto
    ]);

    // Mensaje de conexión exitosa (comentado para no mostrar en producción)
//    echo "Conexión exitosa a PostgreSQL";

} catch (PDOException $e) {
    // Manejo de errores en la conexión
    die("Error de conexión: " . $e->getMessage()); // Termina el script y muestra el error si la conexión falla
    exit; // Asegura que el script se detiene después de mostrar el error
}
?>
