let datosGuardados = localStorage.getItem('usuario');
let usuario = JSON.parse(datosGuardados);


    if (!usuario) {
        window.location.href = "login.html";
    }


    let inq = usuario.tipo;
    let perfil = document.getElementById("perfil");
    perfil.innerHTML = `${usuario.nombre}`;

    perfil.addEventListener("click", () => {
        if(inq === "Inquilino"){
            window.location.href = "perfil-inquilino.html";
        }else if(inq === "Arrendador"){
            window.location.href = "perfil-arrendador.html";
        }
    })


    document.getElementById("registro").addEventListener("click", () => {
        localStorage.removeItem('usuario');
        window.location.href = "login.html";
    });

/* Crear las habitaciones que se ponen en el form y enseñarlas en un div*/   

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


    function publicar(fotoURL) {
        const tarjeta = crearHabitacion(titulo, direccion, zona, precio, tipo, descripcion, fotoURL);
        const contenedor = document.querySelector(".contenedor-habitaciones");

        contenedor.appendChild(tarjeta);
        document.getElementById("formulario").reset();
    }

})


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

    // Botón eliminar: quita la tarjeta del DOM
    div.querySelector(".btn-eliminar-habitacion").addEventListener("click", () => {
        div.remove();
    });

    return div;
}

