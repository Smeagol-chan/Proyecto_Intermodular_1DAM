let datosGuardados = localStorage.getItem('usuario');
let usuario = JSON.parse(datosGuardados);
let listaExistente = JSON.parse(localStorage.getItem('listaUsuarios'));
let inq = usuario.tipo;
let perfil = document.getElementById("perfil");
let con = usuario.contrasenya

//Si no hay usuario, no se puede entrar a esta página
    if (!usuario) {
        window.location.href = "login.html";
    }


    perfil.innerHTML = `${usuario.nombre}`;

    perfil.addEventListener("click", () => {
        if(inq === "Inquilino"){
            window.location.href = "perfil-inquilino.html";
        }else if(inq === "Arrendador"){
            window.location.href = "perfil-arrendador.html";
        }
    })

    //El botón de cerrar sesión quita el usuario del localStorage y manda al login
    document.getElementById("registro").addEventListener("click", () => {
        localStorage.removeItem('usuario');
        window.location.href = "login.html";
    });



/* Crear las habitaciones que se ponen en el form y enseñarlas en un div
Para la foto se crea un objeto URL si hay foto elegida, sino se coge la fotoplaceholder de la carpeta img
*/   
document.getElementById("boton-publicar").addEventListener("click", (e) =>{
    e.preventDefault();

    let titulo = document.getElementById("titulo").value.trim();
    let direccion = document.getElementById("direccion").value.trim();
    let zona = document.getElementById("zona").value.trim();
    let precio = document.getElementById("precio").value;
    let tipo = document.getElementById("tipo").value;
    let descripcion = document.getElementById("descripcion").value.trim();
    let fotosInput = document.getElementById("fotos");
    let foto = fotosInput.files[0]; 

    if (!titulo || !direccion || !precio) {
        alert("Por favor, rellena al menos el título, la dirección y el precio.");
        return;
    }

    if (foto) {
        const fotoURL = URL.createObjectURL(foto);
        publicar(fotoURL);
    } else {
        publicar("img/placeholder.png");
    }

    //Se crea el div tarjeta con la funcion crear habitacion y luego se introduce en el contenedro habitaciones con appendChild
    function publicar(fotoURL) {
        const tarjeta = crearHabitacion(titulo, direccion, zona, precio, tipo, descripcion, fotoURL);
        const contenedor = document.querySelector(".contenedor-habitaciones");

        contenedor.appendChild(tarjeta);
        document.getElementById("formulario").reset();
    }

})

//Funcion para crear el div que se va a insertar en el contenedor habitaciones
function crearHabitacion(titulo, direccion, zona, precio, tipo, descripcion, fotoURL) {

    const div = document.createElement("div");
    div.classList.add("habitacion");

    div.innerHTML = `
        <div class="foto-habitacion">
            <img src="${fotoURL}" alt="Foto de la habitación">
        </div>

        <div class="datos-habitacion">
            <h3>${titulo}</h3>
            <p>${direccion}</p>
            <p>${zona}</p>
        </div>

        <div class="datos-habitacion">
            <p><strong>${precio} €/mes</strong></p>
            <p>${tipo}</p>
            <p>${descripcion}</p>
        </div>

        <button class="btn-eliminar-habitacion">Eliminar</button>
    `;

    // Botón eliminar
    div.querySelector(".btn-eliminar-habitacion").addEventListener("click", () => {
        div.remove();
    });

    return div;
}

//Datos personales y edicion de datos igual que en perfilInq

let contenedor = document.querySelector('.datos-perfil-user');
    contenedor.innerHTML = `
    
        <p><strong>Nombre:</strong> ${usuario.nombre} ${usuario.apellidos}</p>
        <p><strong>Correo:</strong> ${usuario.correo}</p>
        <p><strong>Teléfono:</strong> ${usuario.telefono}</p>
    
    `;

//EDITAR DATOS PERFIL 
let editar_datos = document.getElementById("editar-perfil");
let modal = document.getElementById("modal");
let cerrar_modal = document.getElementById("cerrar-modal");
let guardar_datos_nuevos = document.getElementById("guardar_datos_nuevos");

//Aparecen los datos actuales en el formulario
let input_nombre = document.getElementById("nuevo_nombre").value = usuario.nombre;
let input_apellidos = document.getElementById("nuevo_apellido").value = usuario.apellidos;
let input_correo = document.getElementById("nuevo_correo").value = usuario.correo;
let input_telefono = document.getElementById("nuevo_telefono").value = usuario.telefono;

editar_datos.addEventListener("click", () => modal.showModal());
cerrar_modal.addEventListener("click", () => modal.close());

//Cogemos los nuevos datos que hay en los inputs y se los cambiamos al usuario
guardar_datos_nuevos.addEventListener("click", (e) => {
    e.preventDefault();

    let nuevo_nombre = document.getElementById("nuevo_nombre").value;
    let nuevo_apellidos = document.getElementById("nuevo_apellido").value;
    let nuevo_correo = document.getElementById("nuevo_correo").value;
    let nuevo_telefono = document.getElementById("nuevo_telefono").value;

    //Se compara con todos los usuarios menos consigo mismo para ver si el correo ya existe.
    //some() devuelve true si encuentra un usuario en la lista del local storage con el mismo correo y no cuenta el correo propio actual
    //Si es true no deja guardar los datos nuevos
    let correoExiste = listaExistente.some(user =>
        user.correo === nuevo_correo && user.correo !== usuario.correo
    );
    if (correoExiste) {
        alert("Ya existe un usuario con ese correo");
        return;
    }

    //filter() devuelve un nuevo array con todos los elementos que no cumplan la condición, se queda con todos excepto el que tiene el correo nuevo
    //borro el usuario que estaba usando, y creo uno nuevo con el nuevo correo.
    listaExistente = listaExistente.filter(user => user.correo !== usuario.correo);

    usuario = {
        nombre: nuevo_nombre,
        apellidos: nuevo_apellidos,
        correo: nuevo_correo,
        telefono: nuevo_telefono,
        contrasenya: con,
        tipo: inq
    }


    //Hay que reescribir el innerhtml del contenedor para que se reflejen los cambios
    contenedor.innerHTML = `
    
        <p><strong>Nombre:</strong> ${usuario.nombre} ${usuario.apellidos}</p>
        <p><strong>Correo:</strong> ${usuario.correo}</p>
        <p><strong>Teléfono:</strong> ${usuario.telefono}</p>
    
    `;

    //Reset de los textos del boton de perfil y se vuelve a subir el usuario modificado al localStorage
    perfil.innerHTML = `${usuario.nombre}`;
    localStorage.setItem('usuario', JSON.stringify(usuario))

    //meto el nuevo usuario con los nuevos datos
    listaExistente.push(usuario);
    localStorage.setItem('listaUsuarios', JSON.stringify(listaExistente));

    modal.close();
})

