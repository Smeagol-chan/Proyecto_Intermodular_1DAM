const botonLogin = document.getElementById("crear");

botonLogin.addEventListener("click", (e) => {
    e.preventDefault();

    const correoInput = document.getElementById("email").value.trim();
    const pwdInput = document.getElementById("pwd").value;

    const todos = JSON.parse(localStorage.getItem('listaUsuarios')) || [];

    // Buscar coincidencia
    const encontrado = todos.find(u => u.correo === correoInput && u.contrasenya === pwdInput);
    

    if (encontrado) {
        const inq = encontrado.tipo;
        localStorage.setItem('usuario', JSON.stringify(encontrado));
        if(inq === "Inquilino"){
            window.location.href = "perfil-inquilino.html";
        }else if(inq === "Arrendador"){
            window.location.href = "perfil-arrendador.html";
        }
        
    } else {
        alert("Usuario no encontrado o datos incorrectos");
    }
});