const saludo = function saludar() {
     console.log("Hola")
  };
  
  saludo(); // 'Hola'

  const factorial = function fac(n) {
    var total = 1; 
	for (i=1; i<=n; i++) {
		total = total * i; 
	}
	console.log("El factorial de "+ n +" es "+total ) 
 };

 factorial(5);

 function palindromeChecker(str) {
    const strReversed = str.split("").reverse().join("");
  
    return strReversed === str ? "Es palindromo" : "No es palindromo";
  }
  console.log(palindromeChecker("oso"));
  console.log(palindromeChecker("hola"));
  console.log(palindromeChecker("omo")); 