import processing.serial.*;
Serial miPuerto;
int boton1 = 0, boton2 = 0;
int led1 = 0, led2 = 0;
void setup() 
{
  size(600, 400); // Tamaño de la ventana
  //Muestra en la consola negra de abajo los puertos USB conectados
  printArray(Serial.list()); 
  //El COM3 es el puerto de la PC en donde conecto el Arduino, si lo cambio de puerto debo cambiar COM con el nuevo numero de puerto
  miPuerto = new Serial(this, "COM3", 9600); 
  miPuerto.bufferUntil('\n');//Le decimos que lea la línea completa hasta el "Enter"
}
void draw() 
{
  background(240);//Color de fondo gris claro
  //Textos de las categorías
  fill(0);//Color de texto negro
  textSize(24);
  text("Entradas", 100, 120);
  text("Salidas", 110, 270);
  // Dibujamos las entradas (pulsadores) como rectángulos
  // Botón 1 (E1)
  if (boton1 == 1) fill(0, 255, 0); // Verde si está presionado
  else fill(200);                   // Gris si está suelto
  rect(250, 90, 80, 50, 5);         // x, y, ancho, alto, bordes redondeados
  fill(0); textSize(20); text("E1", 275, 122);
  //Botón 2 (E2)
  if (boton2 == 1) fill(0, 255, 0);
  else fill(200);
  rect(400, 90, 80, 50, 5);
  fill(0); textSize(20); text("E2", 425, 122);
  //Dibujamos las salidas(Leds) como círculos
  //LED 1 (L1)
  if (led1 == 1) fill(255, 0, 0);   // Rojo si el LED físico está prendido
  else fill(200);                   // Gris si el LED físico está apagado
  circle(290, 260, 80);             // x, y (centro), diámetro
  fill(0); textSize(20); text("L1", 277, 267);
  //LED 2 (L2)
  if (led2 == 1) fill(255, 0, 0);
  else fill(200);
  circle(440, 260, 80);
  fill(0); textSize(20); text("L2", 427, 267);
}
//Logica para escuchar al Arduino(Se ejecuta automaticamente cuando llegan los datos)
void serialEvent(Serial p) 
{
  String mensaje= p.readStringUntil('\n'); //Leemos toda la línea
  if (mensaje != null) 
  {
    mensaje= trim(mensaje); //Limpiamos espacios o saltos de línea extra
    int[] datos= int(split(mensaje, ',')); //Cortamos el texto cada vez que hay una coma
    //Si llegaron exactamente los 4 datos (Boton1, Boton2, Led1, Led2)
    if (datos.length == 4) 
    {
      boton1= datos[0];
      boton2= datos[1];
      led1= datos[2];
      led2= datos[3];
    }
  }
}
//Lógica para enviar órenes al Arduino(presionando los círculos)
void mousePressed() 
{
  //Calculamos la distancia desde el puntero del mouse al centro del círculo L1
  float distanciaL1 = dist(mouseX, mouseY, 290, 260);
  if (distanciaL1 < 40) 
  { //Si la distancia es menor al radio del círculo
    miPuerto.write('A'); //Mandamos la letra que el Arduino espera para encender el LED 1
  }
  //Lo mismo para el círculo L2
  float distanciaL2 = dist(mouseX, mouseY, 440, 260);
  if (distanciaL2 < 40) 
  {
    miPuerto.write('B');
  }
}
