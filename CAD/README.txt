===============================================================================================
Universidad Nacional de Colombia -sede Bogotá-
Electrónica Digital 1
Ferney Beltrán
2015-III

Modulo ADC/CAD

Brayan Arguello    25451447 bsarguelloc@unal.edu.co
Manuel Castiblanco 25441187 mscastiblancon@unal.edu.co
Daniel Quica       25441140 dfquicap@unal.edu.co

En el siguiente repositorio encontrará el código para hardware y software, desarrollado 
e implementado para controlar un modulo ADC (Analogic - Digital Converter) usando el 
procesador J1 en una Nexys4. El software se desarrolló en forth, el hardware en verilog
el cual fue sintetizado mediante ISE de Xilinx.

Este modulo trabaja en un circuito el cual consta de 4 fotoresistores, los cuales están 
conectados a un amplificador operacional cuyo objetivo es hacer de más resolución la 
tensión percibida por los fotorresistores. Esta tensión será la entrada al Conversor 
Análogo Digital (CAD) o ACD0808CN en inglés. Desde el modulo hardware se le envia una 
señal especificando que pin de lectura se quiere tener; de manera secuencial, se pide el 
dato del primer fotoresistor, el integrado empieza a convertir y este mismo manda la 
señal cuando los datos están disponibles. De esa misma manera se guardan los valores 
en digital de cada fotoresistor. Empleando la FPGA (Nexys4) como interfaz se mostrará el
funcionamiento del modulo exhibiendo los valores almacenados en la memoria del procesador.



===============================================================================================
