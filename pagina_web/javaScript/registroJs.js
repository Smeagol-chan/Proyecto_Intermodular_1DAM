//Cambio color cuando se pulsan los botones
const botonInquilino = document.getElementById("botonInquilino")
const botonArrendador = document.getElementById("botonArrendador")

let soyInquilino = true;
let soyArrendador = false;

botonInquilino.addEventListener("click",() => {

    soyInquilino = true;
    soyArrendador= false;
    botonInquilino.classList.toggle('botonPulsado')
    botonArrendador.classList.toggle('botonPulsado')
})

botonArrendador.addEventListener("click", () => {
    soyInquilino = false;
    soyArrendador = true;
    botonInquilino.classList.toggle('botonPulsado')
    botonArrendador.classList.toggle('botonPulsado')
})

//Se recogen los valores del formulario para crear el usuario. Se comprueba que esté todo relleno, las contraseñas y que no exista ya un usuario con ese correo.
//Si todo se cumple se crea el usuario y se mete en la lista
const crear = document.getElementById("crear")

crear.addEventListener("click",(e) => {
    e.preventDefault();

    let nombre = document.getElementById("nombre").value;
    let apellidos = document.getElementById("apellidos").value;
    let correo = document.getElementById("email").value;
    let telefono = document.getElementById("telefono").value;
    let contrasenya = document.getElementById("pwd").value;
    let contrasenyaConfirm = document.getElementById("pwd_confirm").value;
    let tipo;
    let checkBox = document.getElementById("confirm").checked;

    if(nombre === "" || apellidos === "" || correo === "" || telefono === "" || contrasenya === "" || contrasenyaConfirm === "" || checkBox === false){
        alert("Rellena todos los campos")

    }else{

        if(contrasenya !== contrasenyaConfirm || contrasenya.length < 8){
            alert("Contraseña tienen que ser iguales y al menos 8 caracteres")

        }else{

            if(soyInquilino === true){
                tipo = "Inquilino"
            }else if(soyArrendador === true){
                tipo = "Arrendador"
            }

            let usuario = {
                nombre: nombre,
                apellidos: apellidos,
                correo: correo,
                telefono: telefono,
                contrasenya: contrasenya,
                tipo: tipo
            }


            let listaExistente = JSON.parse(localStorage.getItem('listaUsuarios')) || [];
            let pararRegistro = false;

            listaExistente.forEach(user => {
                if(user.correo === correo){
                    alert("Ya existe un usuario con ese correo")
                    pararRegistro = true;
                }
            });

            if(pararRegistro){return;}
        
            listaExistente.push(usuario);
            localStorage.setItem('listaUsuarios', JSON.stringify(listaExistente));

            localStorage.setItem('usuario',JSON.stringify(usuario))

            if(soyInquilino === true){
                window.location.href = "perfil-inquilino.html"
            }else if(soyArrendador === true){
                window.location.href = "perfil-arrendador.html"
            }

            
        }


    }



})
