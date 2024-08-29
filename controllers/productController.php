<?php
// Configuración inicial para devolver respuestas JSON y mostrar errores
header('Content-Type: application/json'); // Establecer el tipo de contenido como JSON
ini_set('display_errors', 1); // Mostrar errores
ini_set('display_startup_errors', 1); // Mostrar errores de inicio
error_reporting(E_ALL); // Reportar todos los errores

// Incluir la conexión a la base de datos
require_once '../config/conexion.php';

// Iniciar el almacenamiento en búfer de salida para manejar correctamente las respuestas en caso de error
ob_start();

try {
    // Verificar que la solicitud sea de tipo POST
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        throw new Exception('Método de solicitud no válido.'); // Lanza una excepción si no es POST
    }

    // Sanitizar y validar los datos recibidos del formulario
    // htmlspecialchars es usado para prevenir XSS (Cross-Site Scripting)
    $codigo = htmlspecialchars(filter_input(INPUT_POST, 'codigo', FILTER_DEFAULT), ENT_QUOTES, 'UTF-8');
    $nombre = htmlspecialchars(filter_input(INPUT_POST, 'nombre', FILTER_DEFAULT), ENT_QUOTES, 'UTF-8');
    $precio = filter_input(INPUT_POST, 'precio', FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
    $descripcion = htmlspecialchars(filter_input(INPUT_POST, 'descripcion', FILTER_DEFAULT), ENT_QUOTES, 'UTF-8');
    $bodega_id = filter_input(INPUT_POST, 'bodega', FILTER_VALIDATE_INT);
    $sucursal_id = filter_input(INPUT_POST, 'sucursal', FILTER_VALIDATE_INT);
    $moneda_id = filter_input(INPUT_POST, 'moneda', FILTER_VALIDATE_INT);
    $materiales = filter_input(INPUT_POST, 'materiales', FILTER_DEFAULT, FILTER_REQUIRE_ARRAY);

    // Verificar que todos los campos requeridos estén presentes
    if (empty($codigo) || empty($nombre) || empty($precio) || empty($descripcion) || empty($bodega_id) || empty($sucursal_id) || empty($moneda_id)) {
        throw new Exception('Todos los campos son obligatorios.'); // Lanza una excepción si falta algún campo obligatorio
    }

    // Comprobar si el código del producto ya existe en la base de datos
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM Productos WHERE codigo = :codigo");
    $stmt->execute(['codigo' => $codigo]);

    if ($stmt->fetchColumn() > 0) {
        throw new Exception('El código del producto ya está registrado.'); // Lanza una excepción si el código ya existe
    }

    // Insertar el nuevo producto en la base de datos
    $stmt = $pdo->prepare("INSERT INTO Productos (codigo, nombre, precio, descripcion, materiales, bodega_id, sucursal_id, moneda_id) 
                           VALUES (:codigo, :nombre, :precio, :descripcion, :materiales, :bodega_id, :sucursal_id, :moneda_id)");

    // Ejecutar la inserción con los datos proporcionados
    $stmt->execute([
        'codigo' => $codigo,
        'nombre' => $nombre,
        'precio' => $precio,
        'descripcion' => $descripcion,
        'materiales' => '{' . implode(',', $materiales) . '}', // Convierte el array de materiales en una cadena de texto formateada como un array para PostgreSQL
        'bodega_id' => $bodega_id,
        'sucursal_id' => $sucursal_id,
        'moneda_id' => $moneda_id
    ]);

    // Limpiar el búfer de salida y enviar la respuesta de éxito en formato JSON
    ob_end_clean();
    echo json_encode(['status' => 'success', 'message' => 'Producto registrado exitosamente.']);

} catch (PDOException $e) {
    // En caso de un error de PDO, limpiar el búfer de salida y devolver un mensaje de error en formato JSON
    ob_end_clean();
    echo json_encode(['status' => 'error', 'message' => 'Error al registrar el producto: ' . $e->getMessage()]);
    exit;
} catch (Exception $e) {
    // En caso de una excepción general, limpiar el búfer de salida y devolver un mensaje de error en formato JSON
    ob_end_clean();
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    exit;
}
?>
