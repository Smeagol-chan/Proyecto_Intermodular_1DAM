let datosGuardados = localStorage.getItem('usuario');
let usuario = JSON.parse(datosGuardados);

if (!usuario) {
    window.location.href = "login.html";
} else {
    let perfil = document.getElementById("perfil");
    perfil.innerHTML = `${usuario.nombre}`;

    document.getElementById("registro").addEventListener("click", () => {
        localStorage.removeItem('usuario');
        window.location.href = "login.html";
    });
}