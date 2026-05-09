let datosGuardados = localStorage.getItem('usuario');
let usuario = JSON.parse(datosGuardados);
const ListaHabitciones = document.querySelectorAll(".habitaciones");

if (!usuario) {
    window.location.href = "login.html";
} else {
    let perfil = document.getElementById("perfil");
    perfil.innerHTML = `${usuario.nombre}`;

    document.getElementById("registro").addEventListener("click", () => {
        localStorage.removeItem('usuario');
        window.location.href = "login.html";
    });

    //El boton del perfil manda al perfil de inquilino o de arrendador dependiendo el tipo de usuario
    let inq = usuario.tipo;

    perfil.addEventListener("click", () => {
        if(inq === "Inquilino"){
            window.location.href = "perfil-inquilino.html";
        }else if(inq === "Arrendador"){
            window.location.href = "perfil-arrendador.html";
        }
    })
}

document.getElementById("but_buscar").addEventListener("click", (event) => {
    event.preventDefault();

    const filtro_precio = document.getElementById("precio").value;
    const filtro_opciones = document.getElementById("opciones").value.toLowerCase();
    const filtro_tipo = document.getElementById("tipo").value.toLowerCase();
    const busqueda = document.getElementById("busqueda").value.toLowerCase();

    ListaHabitciones.forEach(habitacion => {
        let precio_habitacion = habitacion.querySelector(".precio_habitacion").textContent.toLowerCase();
        let precio_final = parseInt(precio_habitacion);
        let opciones_habitacion = habitacion.querySelector(".servicios").textContent.toLowerCase();
        let tipo_habitacion = habitacion.querySelector(".caracteristicas").textContent.toLowerCase();
        let ubicacion_habitacion = habitacion.querySelector(".ubicacion").textContent.toLowerCase();

        if (precio_final > parseInt(filtro_precio) && filtro_precio !== 0) {
            habitacion.style.display = "none";
        } else {
            if (precio_final <= parseInt(filtro_precio) && filtro_precio !== 0) {
                habitacion.style.display = "block";
            }
        }

        if (opciones_habitacion.includes(filtro_opciones) && filtro_opciones !== "") {
            habitacion.style.display = "none";
        }

        if (tipo_habitacion.includes(filtro_tipo) && filtro_tipo !== "") {
            habitacion.style.display = "none";
        }

        if (ubicacion_habitacion.includes(busqueda) && busqueda !== "") {
            habitacion.style.display = "none";
        }

        if (busqueda == "" && filtro_opciones == "" && filtro_tipo == "" && filtro_precio == "") {
            habitacion.style.display = "block";
        }

    });
});