### Introducción:
Este repositorio contiene el código fuente para el desarrollo de una interfaz gráfica de control bidireccional entre una computadora y una placa Arduino.

### Esquemático y Hardware Utilizado:
Las conexiones del Arduino UNO se han realizado de la siguiente manera:
* **Entrada 1 (Pulsador 1):** Conectado al Pin Digital 2 utilizando una configuración Pull-Down (con resistencia de 10kΩ a GND).
* **Entrada 2 (Pulsador 2):** Conectado al Pin Digital 3 utilizando una configuración Pull-Down (con resistencia de 10kΩ a GND).
* **Salida 1 (LED 1):** Conectado al Pin Digital 4 utilizando una resistencia limitadora de corriente de 220Ω.
* **Salida 2 (LED 2):** Conectado al Pin Digital 5 utilizando una resistencia limitadora de corriente de 220Ω.

### Lógica de Comunicación:
Para lograr el intercambio de información de entradas y salidas, se estableció un protocolo de comunicación bidireccional a través del puerto Serie (USB):

* **De Arduino a PC:**
El Arduino envía continuamente una trama de texto estructurada con cuatro valores numéricos separados por comas, finalizando con un salto de línea.
* **De PC a Arduino:**
Al hacer clic dentro del área de los círculos (Salidas) en la interfaz gráfica, Processing envía un carácter de control específico:
  * Letra `A`: El Arduino la recibe e invierte el estado lógico del LED 1.
  * Letra `B`: El Arduino la recibe e invierte el estado lógico del LED 2.

### Enlace al video solicitado.
Dicho video contiene los siguientes ítems: Grabación de pantalla ; Implementación real del programa (mediante Arduino) ; Rostro del Alumno

https://drive.google.com/file/d/1Ilc2FVOeLfwouv2MwIt9gcJaIuvlYp-e/view?usp=drivesdk
