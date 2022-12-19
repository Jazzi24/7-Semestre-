function saludo(){
    alert("Hola mundo...")
}











// inicializar constantes del objeto XMLHTTPREQUEST
/*const READY_STATE_UNINTIALIZED = 0
const READY_STATE_LOADING = 1
const READY_STATE_LOADED = 2
const READY_STATE_INTERACTIVE = 3*/
const READY_STATE_COMPLETE = 4
let peticion_http

function cargarContenido(url,metodo,funcion){
    peticion_http = inicializaXHR()
    if(peticion_http){
        peticion_http.onreadystatechange = funcion
        peticion_http.open(metodo,url,true)
        peticion_http.send();
    }
}

function inicializaXHR{
    if(window.XMLHttpRequest){
        return new XMLHttpRequest
    }else{
        return new ActiveObject("Microsft.XMLHTTP")
    }
}

function fnMostrarContenido(){
    if(peticion_http.readyState == READY_STATE_COMPLETE){
        if(peticion_http.status == 200){
            alert(peticion_http.reponseText)
        }

    }
}


function ejemploAjax(){
    cargarContenido("texto.txt","GET",fnMostrarContenido)
}