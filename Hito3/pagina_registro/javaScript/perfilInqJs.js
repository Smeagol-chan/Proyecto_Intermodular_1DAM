let datosGuardados = localStorage.getItem('usuario');
let usuario = JSON.parse(datosGuardados);


    if (!usuario) {
        window.location.href = "login.html";
    }


    let inq = usuario.tipo;
    let perfil = document.getElementById("perfil");
    perfil.innerHTML = `${usuario.nombre}`;
    

    perfil.addEventListener("click", () => {
        if(inq === "Inquilino"){
            window.location.href = "perfil-inquilino.html";
        }else if(inq === "Arrendador"){
            window.location.href = "perfil-arrendador.html";
        }
    })


    document.getElementById("registro").addEventListener("click", () => {
        localStorage.removeItem('usuario');
        window.location.href = "login.html";
    });

    

    let contenedor = document.querySelector('.datos-perfil-user');
    contenedor.innerHTML = `
    
        <p><strong>Nombre:</strong> ${usuario.nombre} ${usuario.apellidos}</p>
        <p><strong>Correo:</strong> ${usuario.correo}</p>
        <p><strong>Teléfono:</strong> ${usuario.telefono}</p>
    
    `;
    
//EDITAR DATOS PERFIL 

let editar_datos = document.getElementById("editar-perfil");
let modal = document.getElementById("modal");
let cerrar_modal = document.getElementById("cerrar-modal");
let guardar_datos_nuevos = document.getElementById("guardar_datos_nuevos");

//Aparecen los datos actuales en el formulario
let input_nombre = document.getElementById("nuevo_nombre").value = usuario.nombre;
let input_apellidos = document.getElementById("nuevo_apellido").value = usuario.apellidos;
let input_correo = document.getElementById("nuevo_correo").value = usuario.correo;
let input_telefono = document.getElementById("nuevo_telefono").value = usuario.telefono;

editar_datos.addEventListener("click", () => modal.showModal());
cerrar_modal.addEventListener("click", () => modal.close());


//Cogemos los nuevos datos que hay en los inputs y se los cambiamos al usuario
guardar_datos_nuevos.addEventListener("click", (e) => {
    e.preventDefault();

    let nuevo_nombre = document.getElementById("nuevo_nombre").value;
    let nuevo_apellidos = document.getElementById("nuevo_apellido").value;
    let nuevo_correo = document.getElementById("nuevo_correo").value;
    let nuevo_telefono = document.getElementById("nuevo_telefono").value;

        usuario = {
            nombre: nuevo_nombre,
            apellidos: nuevo_apellidos,
            correo: nuevo_correo,
            telefono: nuevo_telefono,
        }

        
        //Hay que reescribir el innerhtml del contenedor para que se reflejen los cambios
        contenedor.innerHTML = `
    
        <p><strong>Nombre:</strong> ${usuario.nombre} ${usuario.apellidos}</p>
        <p><strong>Correo:</strong> ${usuario.correo}</p>
        <p><strong>Teléfono:</strong> ${usuario.telefono}</p>
    
    `;

    modal.close();
})