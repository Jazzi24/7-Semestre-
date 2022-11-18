"use strict"
//imprimir en consola
// es un lenguaje interpretado
//
console.log("Hola mundo")
var x = 5;
let y = 10
console.log(typeof y);
let manzana = "roja";
y = "juan";
console.log(typeof y)
console.log(typeof 5.5)
console.log(10<20)
console.log("Ardvark"<"Zoroaster")
console.log("azul"=="negro")
console.log(true && false)

if(2+2 == 3){
    console.log("Es verdadero")
}
else{
    console.log("Es falso")
}

//var let const
let contador = 0;
while(contador < 10){
    console.log("contador"+contador)
    contador++;
    break;
}
let val = true 

val ? console.log("verdadero"):console.log("falso")

if(val){
    console.log("Verdadero")
}else{
    console.log("Falso")
}

//funcion
function cuadrado(x){
    return x*x;
}

const cuadrado2 = function(x){
    return x*x;
}

console.log(cuadrado(4))
console.log(typeof cuadrado2)

const cuadrado3 = (x,y) => {
    return x*x;
}

console.log(cuadrado3(5))

const mayor = (x,y,z) =>{
    if(x>y){
        if(x>z){
            console.log("El mayor "+x)
        }else{
            console.log("El mayor "+z)
        }
    }else{
        if(y>z){
            console.log("El mayor "+y)
        }else
        {
            console.log("El mayor "+z)
        }
    }    
}

console.log(mayor(-2,6,10))

//objetos
//conjunto de datos
let lista = [1,2,3,4]
console.log(lista[4])
lista.push(5)
lista.push(6)
console.log(lista.pop())

//objetos
let dia = {
    hora: 8,
    materia: ["bdd","so","esta","tw2","gp","ing"]
}

console.log(dia.hora)
console.log(dia.materia[0])