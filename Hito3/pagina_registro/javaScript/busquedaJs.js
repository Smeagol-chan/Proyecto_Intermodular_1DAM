let datosGuardados = localStorage.getItem('usuario');
let usuario = JSON.parse(datosGuardados);
const ListaHabitaciones = document.querySelectorAll(".habitaciones");
let perfil = document.getElementById("perfil");
let registro = document.getElementById("registro");

    if(usuario){
        perfil.innerHTML = `${usuario.nombre}`;
        registro.innerHTML= "Cerrar sesión"

        registro.addEventListener("click", () => {
            localStorage.removeItem('usuario');
            window.location.href = "login.html";
        });

    }else{
        perfil.innerHTML = "Iniciar sesión"
        registro.innerHTML = "Registrarse"
        
        perfil.addEventListener("click", () =>{
            window.location.href = "login.html"
        })

        registro.addEventListener("click", () => {
            localStorage.removeItem('usuario');
            window.location.href = "registro.html";
        });

    }

    //El boton del perfil manda al perfil de inquilino o de arrendador dependiendo el tipo de usuario
    let inq = usuario.tipo;

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