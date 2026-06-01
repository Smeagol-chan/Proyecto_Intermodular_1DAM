let datosGuardados = localStorage.getItem('usuario');
let usuario = JSON.parse(datosGuardados);
let perfil = document.getElementById("perfil");
let registro = document.getElementById("registro");
let lugar = "";
let boton = document.getElementById("buscar_index");
let inq;

//Verificar si hay un usuario logueado
//Si hay un usuario el botón de iniciar sesión es el nombre de usuario, el de registro es cerrar sesión y se declara inq segun el tipo de usuario
//Si no hay usuario en el localStorage los botones son iniciar sesicón y registrarse. 
if (usuario) {
    perfil.innerHTML = `${usuario.nombre}`;
    registro.innerHTML = "Cerrar sesión"

    registro.addEventListener("click", () => {
        localStorage.removeItem('usuario');
        window.location.href = "login.html";
    });
    inq = usuario.tipo;

    //El boton del perfil manda al perfil de inquilino o de arrendador dependiendo el tipo de usuario

    perfil.addEventListener("click", () => {
        if (inq === "Inquilino") {
            window.location.href = "perfil-inquilino.html";
        } else if (inq === "Arrendador") {
            window.location.href = "perfil-arrendador.html";
        }
    })

} else {
    perfil.innerHTML = "Iniciar sesión"
    registro.innerHTML = "Registrarse"

    perfil.addEventListener("click", () => {
        window.location.href = "login.html"
    })

    registro.addEventListener("click", () => {
        window.location.href = "registro.html";
    });

}



boton.addEventListener("click", () => {
    lugar = document.getElementById("lugar").value.toLowerCase();
    localStorage.setItem("lugar", lugar);
    window.location.href = "buscar.html";
})




function enviarFormulario() {
    console.log("¡Botón pulsado directamente!");

    const nombre = document.getElementById("nombre");
    const apellidos = document.getElementById("apellidos");
    const email = document.getElementById("email");
    const telefono = document.getElementById("telefono");
    const mensaje = document.getElementById("mensaje");
    const confirm = document.getElementById("confirm");
    const mensajeExito = document.getElementById("mensajeExito");

    if (nombre.value.trim() === "" || apellidos.value.trim() === "" || email.value.trim() === "" || telefono.value.trim() === "" || mensaje.value.trim() === "" || !confirm.checked) {
        alert("Por favor, rellena todos los campos y acepta la política de privacidad.");
        return;
    }

    if (mensajeExito) {
        mensajeExito.textContent = "Gracias por rellenar el formulario, ¡nos pondremos en contacto contigo pronto!";
        mensajeExito.style.color = "#3C7160"; 
        mensajeExito.style.fontWeight = "bold";
        mensajeExito.style.marginTop = "15px";
        mensajeExito.style.display = "block";
    }

    nombre.value = "";
    apellidos.value = "";
    email.value = "";
    telefono.value = "";
    mensaje.value = "";
    confirm.checked = false;
    
}