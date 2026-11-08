Introducción:
Este repositorio contiene el código fuente para el desarrollo de una interfaz gráfica de control bidireccional entre una computadora y una placa Arduino. El sistema permite leer el estado de entradas físicas(pulsadores) y visualizarlos en pantalla en tiempo real, así como controlar salidas físicas(LEDs) interactuando directamente con la interfaz gráfica mediante el mouse.

Esquemático y Hardware Utilizado:
Las conexiones del Arduino UNO se han realizado de la siguiente manera:
*   **Entrada 1(Pulsador 1):** Conectado al *Pin Digital 2* utilizando una configuración Pull-Down (con resistencia de 10kΩ a GND).
*   **Entrada 2(Pulsador 2):** Conectado al *Pin Digital 3* utilizando una configuración Pull-Down (con resistencia de 10kΩ a GND).
*   **Salida 1(LED 1):** Conectado al *Pin Digital 4* utilizando una resistencia limitadora de corriente de 220Ω.
*   **Salida 2(LED 2):** Conectado al *Pin Digital 5* utilizando una resistencia limitadora de corriente de 220Ω.

Lógica de Comunicación:
Para lograr el intercambio de información de entradas y salidas, se estableció un protocolo de comunicación bidireccional a través del puerto Serial(USB):
*   **De Arduino a PC:** 
    El Arduino envía continuamente una trama de texto estructurada con cuatro valores numéricos separados por comas, finalizando con un salto de línea. El formato es: `Boton1,Boton2,Led1,Led2\n` (donde `1` representa HIGH y `0` representa LOW). Processing interpreta esta cadena mediante la función `split()` para actualizar dinámicamente los colores de la interfaz.
*   **De PC a Arduino:** 
    Al hacer clic dentro del área de los círculos(Salidas) en la interfaz gráfica, Processing envía un carácter de control específico:
    *   Letra `'A'`: El Arduino la recibe e invierte el estado lógico del LED 1.
    *   Letra `'B'`: El Arduino la recibe e invierte el estado lógico del LED 2.

Instrucciones de Ejecución:
1. Conectar la placa Arduino y cargar el archivo `TP7_Codigo_Arduino.ino`.
2. ¡Importante! Asegurarse de cerrar el Monitor Serie del IDE de Arduino(para liberar el puerto COM)
3. Abrir el archivo `TP7_Interfaz_Processing.pde` en el entorno de Processing.
4. Verificar que la inicialización del objeto `Serial` coincida con el puerto COM asignado físicamente a la placa.
5. Ejecutar el sketch para inicializar el entorno gráfico interactivo.
