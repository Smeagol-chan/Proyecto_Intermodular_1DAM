let datosGuardados = localStorage.getItem('usuario');
let usuario = JSON.parse(datosGuardados);
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