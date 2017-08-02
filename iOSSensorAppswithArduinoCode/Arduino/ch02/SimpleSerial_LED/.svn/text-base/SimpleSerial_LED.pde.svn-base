

void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
}

void loop() {
  while (Serial.available() <= 0) {
    Serial.println("Hello world");   
    delay(300);
  }

  Serial.println("Goodbye world");
  while(1) { 
     digitalWrite(13, HIGH);
     delay(1000);
     digitalWrite(13, LOW);
     delay(1000);
  }
}

