const botonLogin = document.getElementById("crear");

//Se coge lo escrito en los input y se busca coincidencia en la lista de usuarios que hay en el localStorage
//Si se encuentra se declara un objeto usuario en el local storage con el usuario encontrado, este se usa para el navegador
//Según el tipo de usuario se manda a perfil inquilino o perfil arrendador

botonLogin.addEventListener("click", (e) => {
    e.preventDefault();

    const correoInput = document.getElementById("email").value.trim();
    const pwdInput = document.getElementById("pwd").value;

    const todos = JSON.parse(localStorage.getItem('listaUsuarios')) || [];

    // Buscar coincidencia
    const encontrado = todos.find(u => u.correo === correoInput && u.contrasenya === pwdInput);
    

    if (encontrado) {
        localStorage.setItem('usuario', JSON.stringify(encontrado));
        const inq = encontrado.tipo;
        if(inq === "Inquilino"){
            window.location.href = "perfil-inquilino.html";
        }else if(inq === "Arrendador"){
            window.location.href = "perfil-arrendador.html";
        }
        
    } else {
        alert("Usuario no encontrado o datos incorrectos");
    }
});