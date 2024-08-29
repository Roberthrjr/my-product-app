// Evento que se ejecuta cuando el DOM ha sido completamente cargado
document.addEventListener('DOMContentLoaded', function () {
    // Cargar los datos de bodegas, sucursales y monedas cuando la página se carga
    fetch('/apps/my-product-app/controllers/getData.php')
        .then(response => response.json()) // Analizar la respuesta como JSON
        .then(data => {
            // Si hay datos de bodegas disponibles, se llenan en el select correspondiente
            if (data.bodegas) {
                const bodegaSelect = document.getElementById('bodega');
                data.bodegas.forEach(bodega => {
                    const option = document.createElement('option');
                    option.value = bodega.id; // Asigna el ID de la bodega como valor
                    option.textContent = bodega.nombre; // Muestra el nombre de la bodega
                    bodegaSelect.appendChild(option); // Añade la opción al select de bodegas
                });
            }

            // Si hay datos de sucursales, se almacenan en el dataset del select para uso posterior
            if (data.sucursales) {
                const sucursalSelect = document.getElementById('sucursal');
                sucursalSelect.dataset.sucursales = JSON.stringify(data.sucursales); // Guarda las sucursales como JSON
            }

            // Si hay datos de monedas disponibles, se llenan en el select correspondiente
            if (data.monedas) {
                const monedaSelect = document.getElementById('moneda');
                data.monedas.forEach(moneda => {
                    const option = document.createElement('option');
                    option.value = moneda.id; // Asigna el ID de la moneda como valor
                    option.textContent = `${moneda.nombre} (${moneda.simbolo})`; // Muestra el nombre y símbolo de la moneda
                    monedaSelect.appendChild(option); // Añade la opción al select de monedas
                });
            }
        })
        .catch(error => console.error('Error al cargar los datos:', error)); // Maneja errores en la carga de datos
});

// Evento que se ejecuta cuando cambia la selección de bodega
document.getElementById('bodega').addEventListener('change', function () {
    const bodegaId = this.value; // Obtiene el ID de la bodega seleccionada
    const sucursalSelect = document.getElementById('sucursal');

    // Limpiar las opciones anteriores del select de sucursales
    sucursalSelect.innerHTML = '<option value="" selected disabled>Seleccione una sucursal</option>';

    // Obtener las sucursales almacenadas en el dataset
    const sucursales = JSON.parse(sucursalSelect.dataset.sucursales);

    // Filtrar y mostrar las sucursales asociadas a la bodega seleccionada
    const filteredSucursales = sucursales.filter(sucursal => sucursal.bodega_id == bodegaId);
    filteredSucursales.forEach(sucursal => {
        const option = document.createElement('option');
        option.value = sucursal.id; // Asigna el ID de la sucursal como valor
        option.textContent = sucursal.nombre; // Muestra el nombre de la sucursal
        sucursalSelect.appendChild(option); // Añade la opción al select de sucursales
    });

    // Si no hay sucursales para la bodega seleccionada
    if (filteredSucursales.length === 0) {
        const noOption = document.createElement('option');
        noOption.value = ''; // Valor vacío para indicar la ausencia de sucursales
        noOption.textContent = 'No hay sucursales disponibles'; // Mensaje informativo
        sucursalSelect.appendChild(noOption); // Añade la opción al select de sucursales
    }
});

// Evento que se ejecuta cuando se envía el formulario
document.getElementById('productForm').addEventListener('submit', function (event) {
    event.preventDefault(); // Prevenir el envío del formulario de manera tradicional

    // Validaciones personalizadas
    const codigo = document.getElementById('codigo').value.trim(); // Obtiene y limpia el valor del código
    const nombre = document.getElementById('nombre').value.trim(); // Obtiene y limpia el valor del nombre
    const precio = document.getElementById('precio').value.trim(); // Obtiene y limpia el valor del precio
    const descripcion = document.getElementById('descripcion').value.trim(); // Obtiene y limpia el valor de la descripción
    const materiales = document.querySelectorAll('input[name="materiales[]"]:checked'); // Obtiene los materiales seleccionados
    const bodega = document.getElementById('bodega').value; // Obtiene el ID de la bodega seleccionada
    const sucursal = document.getElementById('sucursal').value; // Obtiene el ID de la sucursal seleccionada
    const moneda = document.getElementById('moneda').value; // Obtiene el ID de la moneda seleccionada

    // Validaciones de cada campo
    if (codigo === '' || !/^[A-Za-z0-9]+$/.test(codigo) || codigo.length < 5 || codigo.length > 15) {
        alert('El código del producto es obligatorio, debe tener entre 5 y 15 caracteres, y contener solo letras y números.');
        return; // Detener el envío si la validación falla
    }

    if (nombre === '' || nombre.length < 2 || nombre.length > 50) {
        alert('El nombre del producto es obligatorio y debe tener entre 2 y 50 caracteres.');
        return; // Detener el envío si la validación falla
    }

    if (precio === '' || !/^\d+(\.\d{1,2})?$/.test(precio)) {
        alert('El precio del producto es obligatorio y debe ser un número positivo con hasta dos decimales.');
        return; // Detener el envío si la validación falla
    }

    if (materiales.length < 2) {
        alert('Debe seleccionar al menos dos materiales para el producto.');
        return; // Detener el envío si la validación falla
    }

    if (descripcion === '' || descripcion.length < 10 || descripcion.length > 1000) {
        alert('La descripción del producto es obligatoria y debe tener entre 10 y 1000 caracteres.');
        return; // Detener el envío si la validación falla
    }

    if (bodega === '') {
        alert('Debe seleccionar una bodega.');
        return; // Detener el envío si la validación falla
    }

    if (sucursal === '') {
        alert('Debe seleccionar una sucursal para la bodega seleccionada.');
        return; // Detener el envío si la validación falla
    }

    if (moneda === '') {
        alert('Debe seleccionar una moneda para el producto.');
        return; // Detener el envío si la validación falla
    }

    // Si todas las validaciones son exitosas, proceder a enviar los datos
    const formData = new FormData(this); // Crear un FormData con los datos del formulario

    // Enviar los datos al servidor mediante fetch
    fetch('/apps/my-product-app/controllers/productController.php', {
        method: 'POST', // Método de envío
        body: formData // Cuerpo de la solicitud con los datos del formulario
    })
        .then(response => response.text())  // Leer la respuesta como texto
        .then(data => {
            try {
                const jsonData = JSON.parse(data);  // Intenta parsear la respuesta como JSON
                if (jsonData.status === 'success') {
                    alert(jsonData.message); // Mostrar mensaje de éxito
                    document.getElementById('productForm').reset(); // Resetear el formulario
                } else {
                    alert('Error: ' + jsonData.message); // Mostrar mensaje de error
                }
            } catch (error) {
                console.error('Error al parsear JSON:', error); // Manejar errores de parsing
            }
        })
        .catch(error => {
            console.error('Error:', error); // Manejar errores de la solicitud
            alert('Hubo un problema al procesar la solicitud.');
        });
});
