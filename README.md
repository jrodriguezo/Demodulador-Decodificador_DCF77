# Demodulador-Decodificador_DCF77

Cuenta desde 19:30 y acaba en 19:39 (incrementando cada "minuto" con 15 segundos)

### Explicación básica del funcionamiento
  A la salida del circuito analógico presentamos una señal cuadrada entre 0 y 5 V que son los valores con las que podemos trabajar con la FPGA. 
  
  Con el “registro de desplazamiento de 40 bits”, capturamos bit a bit la señal a una frecuencia de 40 muestras/s  
  
  Para obtener la suma de dichas muestras necesitamos un “integrador” 
  
  Con ello lo compararemos con 2 umbrales para decidir si es un 1 (32 “1s” y 8 “0s”) o un 0 (36 “1s” y 4 “0s”) , es decir un pulso que tiene a valor 0 durante 200 ms y 100 ms respectivamente (también necesitaremos la ayuda de una puerta “AND” para crear dichas decisiones) 
 
 El autómata cuando determine a qué valor se refiere, lo irá almacenando en “registro”. Como una trama se compone de [14 bits + SYNC] (15 segundos) , cuando llegue a éste último el autómata validará la trama poniendo un 1 en el enable de “registro de validación” , dejando pasar así los bits almacenados para su posterior visualización en el display. 
 
 El módulo de visualización está compuesto por un multiplexor que se encargará de escoger los 4 bits que representan un número del 0 al 9. Éstos se decodifican con un decodificador a 7 segmentos y con ayuda del módulo de refresco logramos cambiar de display, y a su vez escoger los 4 bits siguientes del multiplexor para su representación, repitiendo este último paso hasta terminar la trama.
