//Definición de pines
const int boton1Pin= 2;
const int boton2Pin= 3;
const int led1Pin= 4;
const int led2Pin= 5;
//Variables para guardar el estado de los LEDs
bool estadoLed1= false;
bool estadoLed2= false;
//Variables para el antirebote de los pulsadores(inician en LOW)
bool ultimoEstadoBoton1= LOW;
bool ultimoEstadoBoton2= LOW;
void setup() 
{
  Serial.begin(9600); 
  //Configuramos pines
  pinMode(boton1Pin, INPUT);
  pinMode(boton2Pin, INPUT);
  pinMode(led1Pin, OUTPUT);
  pinMode(led2Pin, OUTPUT);
}
void loop() 
{
  //Leemos las entradas y controlamos las salidas fisicamente
  bool estadoActualBoton1 = digitalRead(boton1Pin);
  bool estadoActualBoton2 = digitalRead(boton2Pin);
  //Lógica Botón 1: Si se acaba de presionar (pasa de LOW a HIGH por el Pull-Down)
  if (estadoActualBoton1 == HIGH && ultimoEstadoBoton1 == LOW) 
  {
    estadoLed1= !estadoLed1; 
    digitalWrite(led1Pin, estadoLed1);
    delay(50); //Antirebote
  }
  ultimoEstadoBoton1= estadoActualBoton1;
  //Lógica Botón 2
  if (estadoActualBoton2 == HIGH && ultimoEstadoBoton2 == LOW) 
  {
    estadoLed2= !estadoLed2;
    digitalWrite(led2Pin, estadoLed2);
    delay(50);
  }
  ultimoEstadoBoton2 = estadoActualBoton2;
  //Escuchamos a la PC (processing)
  if (Serial.available() > 0) 
  {
    char orden= Serial.read();
    if (orden == 'A') 
    {
      estadoLed1= !estadoLed1;
      digitalWrite(led1Pin, estadoLed1);
    } else if (orden == 'B') 
    {
      estadoLed2= !estadoLed2;
      digitalWrite(led2Pin, estadoLed2);
    }
  }
  //Enviamos datos a la PC para dibujar la interfaz
  //La lógica es directa: HIGH es 1, LOW es 0
  int envioBoton1= (estadoActualBoton1 == HIGH) ? 1 : 0;
  int envioBoton2= (estadoActualBoton2 == HIGH) ? 1 : 0;
  int envioLed1= estadoLed1 ? 1 : 0;
  int envioLed2= estadoLed2 ? 1 : 0;
  //Imprimimos el mensaje final: ej. "1,0,1,0"
  Serial.print(envioBoton1); Serial.print(",");
  Serial.print(envioBoton2); Serial.print(",");
  Serial.print(envioLed1);   Serial.print(",");
  Serial.println(envioLed2);
  delay(30); 
}