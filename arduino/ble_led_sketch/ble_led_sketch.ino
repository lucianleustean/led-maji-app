/*
 * Created by Lucian Leustean, http://lucianleustean.com/
 * Control Arduino 3 LEDs using Mobile app via Bluetooth LE
 * 2015
 */

// Avoid removing the BLE sensor everytime
#define BT_RX_PIN 2
#define BT_TX_PIN 3

#include <SoftwareSerial.h>
SoftwareSerial BTSerial(BT_RX_PIN, BT_TX_PIN);

// Assign pin number for LED
int redPin = 13;
int greenPin = 12;
int bluePin = 11;

String readString;

void setup() {
  // initialize serial communication
  Serial.begin(9600);
  BTSerial.begin(9600);

  // initialize the LED pins;
  for (int thisPin = 11; thisPin < 14; thisPin++) {
    pinMode(thisPin, OUTPUT);
  }
}

void loop() {
  while (BTSerial.available() > 0) {
    delay(3);
    char c = BTSerial.read();
    readString += String(c);
  }

  if (readString.length() > 0) {
    Serial.print(readString);

    if (readString == "red") {
      digitalWrite(redPin, HIGH);
      digitalWrite(bluePin, LOW);
      digitalWrite(greenPin, LOW);
    }

    if (readString == "blue") {
      digitalWrite(bluePin, HIGH);
      digitalWrite(redPin, LOW);
      digitalWrite(greenPin, LOW);
    }

    if (readString == "green") {
      digitalWrite(greenPin, HIGH);
      digitalWrite(bluePin, LOW);
      digitalWrite(redPin, LOW);
    }

    readString = "";
  }
}

