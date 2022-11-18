const READY_STATE_UNINITIALIZED = 0
const READY_STATE_LOADING = 1
const READY_STATE_LOADED = 2
const READY_STATE_INTERACTIVE = 3
const READY_STATE_COMPLETE = 4

let peticion_http;

let cargaContenido = (url, metodo, funcion) => {
  peticion_http = inicializa_xhr();

  if (peticion_http) {
    peticion_http.onreadystatechange = funcion;
    peticion_http.open(metodo, url, true);
    peticion_http.send(null);
  }
}

function inicializa_xhr() {
  if (window.XMLHttpRequest) {
    return new XMLHttpRequest();
  }
  else if (window.ActiveXObject) {
    return new ActiveXObject("Microsoft.XMLHTTP");
  }
}

function muestraContenido() {
  if (peticion_http.readyState == READY_STATE_COMPLETE) {
    if (peticion_http.status == 200) {
      var jsonResponse = peticion_http.responseText;
      var objeto_json = JSON.parse(jsonResponse);
      var suneo = objeto_json.suneo.universidades;

      for (var i = 0; i < suneo.length; i++) {
        var universidades = objeto_json.suneo.universidades[i].abreviatura;
        document.getElementById('universidad' + i).hidden=false
        document.getElementById('universidad' + i).value = universidades
      }
    }
  }
}

function descargaArchivo() {
  cargaContenido("Universidades.json", "GET", muestraContenido);
}

/** mostrarOfertaEducativa **/
let mostrarOfertaEducativa = () =>{
  alert('Mi oferta')
}