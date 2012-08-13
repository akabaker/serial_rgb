String inputString = "";
boolean stringComplete = false;
int red = 3;
int green = 6;
int blue = 5;

void setup() {
  //Set the RGB pins as OUTPUT
  pinMode(green, OUTPUT);
  pinMode(blue, OUTPUT);
  pinMode(red, OUTPUT);
  
  //Turn them off first
  digitalWrite(red, HIGH);
  digitalWrite(green, HIGH);
  digitalWrite(blue, HIGH);
  
  Serial.begin(9600);
  Serial.println("Ready");
}  

void loop() {
  /*
   According to http://arduino.cc/en/Tutorial/SerialEvent
   serialEvent() is called each time loop() runs. Not
   Sure why this has to be invoked manually.
   */
  serialEvent();
  
  if (stringComplete) {
    //The first character is the color, the second is the state,
    //which will be a '1' or '0' for high and low.
    activatePins(char(inputString.charAt(0)), char(inputString.charAt(1)));
    //Set this to empty and false for the next serial event.
    inputString = "";
    stringComplete = false;
  }
}

void activatePins(char color, char state) {
  //Activate pins based on the desired color and state
  if (color == 'r') {
    digitalWrite(red, getState(state));   
  }
  if (color == 'g') {
    digitalWrite(green, getState(state));
  }
  if (color == 'b') {
    digitalWrite(blue, getState(state));
  }
}

boolean getState(char state) {
  //Return HIGH or LOW based on char '1' or '0'
  if (state == '1') {
    return HIGH;
  } else {
    return LOW;
  }
}

void serialEvent() {
  while (Serial.available() > 0) {
    char inChar = Serial.read();
    inputString += inChar;
    //If newline is next incoming char then the string is complete
    if (inChar == '\n') {
      stringComplete = true;
    }
  }
}
