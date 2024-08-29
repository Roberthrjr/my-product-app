<?php
// Incluir la conexión a la base de datos
require_once '../config/conexion.php';

$response = []; // Array para almacenar los resultados de la consulta

try {
    // Obtener todas las bodegas desde la base de datos
    $stmt = $pdo->query("SELECT id, nombre FROM Bodegas"); // Ejecuta la consulta SQL
    $bodegas = $stmt->fetchAll(PDO::FETCH_ASSOC); // Obtiene todos los resultados como un array asociativo
    $response['bodegas'] = $bodegas; // Añade los resultados al array de respuesta

    // Obtener todas las sucursales desde la base de datos
    $stmt = $pdo->query("SELECT id, nombre, bodega_id FROM Sucursales");
    $sucursales = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $response['sucursales'] = $sucursales;

    // Obtener todas las monedas desde la base de datos
    $stmt = $pdo->query("SELECT id, nombre, simbolo FROM Monedas");
    $monedas = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $response['monedas'] = $monedas;

    // Devuelve la respuesta como JSON
    echo json_encode($response);
} catch (PDOException $e) {
    // En caso de error, devuelve un mensaje de error como JSON
    echo json_encode(['status' => 'error', 'message' => 'Error al obtener los datos: ' . $e->getMessage()]);
}
