let datosGuardados = localStorage.getItem('usuario');
let usuario = JSON.parse(datosGuardados);
const ListaHabitaciones = document.querySelectorAll(".habitaciones");
let perfil = document.getElementById("perfil");
let registro = document.getElementById("registro");
let inq;

if (usuario) {
    perfil.innerHTML = `${usuario.nombre}`;
    registro.innerHTML = "Cerrar sesión"

    registro.addEventListener("click", () => {
        localStorage.removeItem('usuario');
        window.location.href = "login.html";
    });
    inq = usuario.tipo;

} else {
    perfil.innerHTML = "Iniciar sesión"
    registro.innerHTML = "Registrarse"

    perfil.addEventListener("click", () => {
        window.location.href = "login.html"
    })

    registro.addEventListener("click", () => {
        localStorage.removeItem('usuario');
        window.location.href = "registro.html";
    });

}

//El boton del perfil manda al perfil de inquilino o de arrendador dependiendo el tipo de usuario


perfil.addEventListener("click", () => {
    if (inq === "Inquilino") {
        window.location.href = "perfil-inquilino.html";
    } else if (inq === "Arrendador") {
        window.location.href = "perfil-arrendador.html";
    }
})


document.getElementById("but_buscar").addEventListener("click", (event) => {
    event.preventDefault();

    const filtro_precio = document.getElementById("precio").value;
    const filtro_opciones = document.getElementById("opciones").value.toLowerCase();
    const filtro_tipo = document.getElementById("tipo").value.toLowerCase();
    const busqueda = document.getElementById("busqueda").value.toLowerCase();

    ListaHabitaciones.forEach(habitacion => {
        let precio_habitacion = habitacion.querySelector(".precio_habitacion").textContent.toLowerCase();
        let precio_final_habitacion = parseInt(precio_habitacion);
        let tipo_habitacion = habitacion.querySelector(".caracteristicas").textContent.toLowerCase();
        let ubicacion_habitacion = habitacion.querySelector(".ubicacion").textContent.toLowerCase();

        let servicios_habitaciones = habitacion.querySelectorAll(".servicios");
        let mostrar = true;

        if (filtro_precio !== "" && precio_final_habitacion > parseInt(filtro_precio))
            mostrar = false;

        let tiene_servicio = false;
        servicios_habitaciones.forEach(servicios => {
            if (servicios.textContent.toLowerCase().includes(filtro_opciones)) {
                tiene_servicio = true;
            }
        });

        if (filtro_opciones !== "" && !tiene_servicio)
            mostrar = false;

        if (filtro_tipo !== "" && !tipo_habitacion.includes(filtro_tipo))
            mostrar = false;

        if (busqueda !== "" && !ubicacion_habitacion.includes(busqueda))
            mostrar = false;

        if (busqueda == "" && filtro_opciones == "" && filtro_tipo == "" && filtro_precio == "") {
            mostrar = true;
        }

        if (mostrar) {
            habitacion.style.display = "flex";
        } else {
            habitacion.style.display = "none";
        }
    });
});

/* ENSEÑAR MODAL AL PULSAR EN UNA HABITACIÓN*/

let modal = document.getElementById("modal")
let cerrar_modal = document.getElementById("cerrar-modal")

ListaHabitaciones.forEach(habitacion => {
    habitacion.addEventListener("click", () => {

        let imagen = habitacion.querySelector("img").src;
        let titulo = habitacion.querySelector("h2").textContent;
        let ubicacion = habitacion.querySelector(".ubicacion").textContent;
        let superficie = habitacion.querySelector(".superficie").textContent;
        let precio = habitacion.querySelector(".precio_habitacion").textContent;
        let servicios = habitacion.querySelector(".servicios").textContent;

        let servicios2 = habitacion.querySelector(".servicios_dos");
        if (servicios2 !== null) {
            servicios2 = servicios2.textContent;
        }

        let caracteristicas = habitacion.querySelector(".caracteristicas").textContent;


        modal.querySelector("img").src = imagen;
        modal.querySelector("h2").textContent = titulo;
        modal.querySelector(".ubicacion").textContent = ubicacion;
        modal.querySelector(".superficie").textContent = superficie;
        modal.querySelector(".precio_habitacion").textContent = precio;
        modal.querySelector(".servicios").textContent = servicios;
        modal.querySelector(".servicios_dos").textContent = servicios2;
        modal.querySelector(".caracteristicas").textContent = caracteristicas;

        modal.showModal();

        //meter el div creado en el local storage al darle al botón de pedir visita
        let guardarHabitacion = document.getElementById('pedir_visita');
        guardarHabitacion.addEventListener("click", () =>{
            if(inq === "Inquilino"){
                let div = crearHabitacion(titulo,ubicacion,superficie,precio,servicios,servicios2,caracteristicas,imagen)
                localStorage.setItem('divHabitacion',div)
                alert("Se ha solicitado una visita.");
                modal.close();
            }
            if(inq === "Arrendador"){
                alert("Eres arrendador, no puedes solicitar una visita.")
                modal.close();
            }
            if(inq === undefined){
                window.location.href = "login.html"
            }
        })

        

    })


});

cerrar_modal.addEventListener("click", () => {
    modal.close()
})



/*
GUARDAR HABITACION EN LOCAL STORAGE
Esta funcion crea un div para insertar en la página de inquilino. El innerhtml del div se sube al local storage para más tarde sacarlo e insertarlo en el perfil inquilino
*/

function crearHabitacion(titulo, zona, superficie, precio, servicios, servicios2, caracteristicas, fotoURL) {

    const div = document.createElement("div");

    div.innerHTML = `
        <div class="habitacion">
            <div class="foto-habitacion">
                <img src="${fotoURL}" alt="Foto de la habitación">
            </div>

            <div class="datos-habitacion">
                <h3>${titulo}</h3>
                <p>${zona}</p>
                <p>${superficie}</p>
                <p><strong>${precio}</strong></p>
            </div>

            <div class="datos-habitacion">
                <p>${caracteristicas}</p>
                <p>${servicios}</p>
                <p>${servicios2}</p>
            </div>

            <button class="btn-eliminar-habitacion">Eliminar</button>
        </div>
    `;

    return div.innerHTML;
}


