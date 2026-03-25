//Recoger localStorage

let datosGuardados = localStorage.getItem('usuario')
let usuario = JSON.parse(datosGuardados)

document.getElementById("registro").addEventListener("click",() => {
    window.location.href = "registro.html"
})


//
let perfil = document.getElementById("perfil")
perfil.innerHTML = `${usuario.nombre}`

//hacer tabla
let contenedor = document.querySelector('.contenedor')
contenedor.innerHTML = `
                        Nombre: ${usuario.nombre} <br>
                        Apellidos: ${usuario.apellidos}<br>
                        Correo: ${usuario.correo}<br>
                        Teléfono: ${usuario.telefono}<br>
                        Contraseña: ${usuario.contrasenya}<br>
                        Tipo: ${usuario.tipo}<br>

                            `