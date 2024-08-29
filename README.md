
# Sistema de Registro de Productos

Este proyecto es una aplicación web sencilla para gestionar el registro de productos en una base de datos. La aplicación permite a los usuarios registrar productos, seleccionando detalles como la bodega, sucursal, y moneda, además de ingresar un código, nombre, precio, descripción, y materiales asociados al producto.

## Estructura del Proyecto

```
/my-product-app
│
├── /assets              # Archivos estáticos como CSS, JS, imágenes
│   ├── /css
│   │   └── styles.css   # Estilos CSS del proyecto
│   └── /js
│       └── script.js    # Código JavaScript para la interacción en el frontend
│
├── /config              # Configuraciones del proyecto
│   ├── conexion.php     # Archivo para manejar la conexión a la base de datos
│   └── config.php       # Archivo de configuración para la base de datos
│
├── /controllers         # Controladores que manejan la lógica del servidor
│   ├── productController.php  # Controlador para gestionar productos
│   └── getData.php      # Controlador para obtener datos de la base de datos
│
├── /sql                 # Carpeta que maneja el archivo para la creación de base de datos
│   └── my_product_db.sql  # Archivo sql para generar la base de datos y sus respectivas tablas
│
└── /views               # Páginas que el usuario final verá
    └── index.html       # Página principal con el formulario de productos
```

## Tecnologías Utilizadas

- **HTML5**: Estructura de la página web.
- **CSS3**: Estilos para la interfaz de usuario.
- **JavaScript (ES6+)**: Lógica del lado del cliente y validaciones.
- **PHP**: Lógica del lado del servidor, manejo de datos y conexión a la base de datos.
- **PostgreSQL**: Sistema de gestión de bases de datos para almacenar los productos registrados.
- **AJAX**: Comunicación asíncrona entre el frontend y el backend.

## Requisitos del Sistema

- Servidor web con soporte para PHP 8.2 o superior.
- PostgreSQL 16 o superior.
- Navegador moderno compatible con ES6.

## Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/tu-usuario/my-product-app.git
   ```

2. **Configurar la base de datos**:
    - Crea una base de datos en PostgreSQL.
    - Ejecuta las consultas SQL necesarias para crear las tablas `Bodegas`, `Sucursales`, `Monedas`, y `Productos`.
    - Asegúrate de que los datos iniciales para bodegas, sucursales y monedas estén insertados en la base de datos.

3. **Configurar la aplicación**:
    - En el archivo `config.php`, actualiza las credenciales de la base de datos según tu configuración local:
      ```php
      return [
          'db_host' => 'localhost',
          'db_port' => '5432',
          'db_name' => 'nombre_de_tu_base_de_datos',
          'db_user' => 'tu_usuario',
          'db_password' => 'tu_contraseña',
      ];
      ```

4. **Iniciar el servidor**:
    - Si estás usando `XAMPP`, mueve el proyecto a la carpeta `htdocs` y accede a `http://localhost/my-product-app/views/`.
    - Accede a `http://localhost:8000/index.html`.

## Uso

1. **Registro de Productos**:
    - Accede al formulario en `index.html` y completa los campos requeridos.
    - Selecciona al menos dos materiales, y completa el resto de la información.
    - Haz clic en "Guardar Producto" para registrar el producto en la base de datos.

2. **Validaciones**:
    - Los campos de entrada son validados tanto en el cliente (JavaScript) como en el servidor (PHP).
    - Asegúrate de que el código del producto sea único; de lo contrario, el registro fallará.

## Estructura de la Base de Datos

- **Productos**: Contiene los productos registrados con campos como código, nombre, precio, descripción, materiales, etc.
- **Bodegas**: Almacena las bodegas disponibles.
- **Sucursales**: Relacionadas con las bodegas, almacenan las sucursales.
- **Monedas**: Contiene los tipos de monedas utilizadas en el sistema.

## Contribución

Las contribuciones son bienvenidas. Si deseas contribuir, por favor sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza tus cambios y haz un commit (`git commit -m 'Añadir nueva funcionalidad'`).
4. Sube tus cambios (`git push origin feature/nueva-funcionalidad`).
5. Abre un Pull Request.

## Autor

- **Roberth Jason Rios Jesus** - Ingeniero de Sistemas.
