const botonLogin = document.getElementById("crear");

botonLogin.addEventListener("click", (e) => {
    e.preventDefault();

    const correoInput = document.getElementById("email").value.trim();
    const pwdInput = document.getElementById("pwd").value;

    const todos = JSON.parse(localStorage.getItem('listaUsuarios')) || [];

    // Buscar coincidencia
    const encontrado = todos.find(u => u.correo === correoInput && u.contrasenya === pwdInput);

    if (encontrado) {
        localStorage.setItem('usuario', JSON.stringify(encontrado));
        window.location.href = "perfil.html";
    } else {
        alert("Usuario no encontrado o datos incorrectos");
    }
});