// Using Serial1 for communication between ESP32s (Slave)

unsigned long long number = 0;

void setup() {
  Serial.begin(115200);                       // Serial monitor
  Serial1.begin(115200, SERIAL_8N1, 16, 17);  // RX pin = 16, TX pin = 17 (adjust these pins if needed)

  Serial.println("Slave ready. Waiting for communication.");
}

void loop() {
  // Slave receives and sends back incremented number
  if (Serial1.available() >= sizeof(number)) {
    Serial1.readBytes((char*)&number, sizeof(number));  // Read the received 64-bit number

    // Print the received number
    Serial.print("Received from Master ESP32: ");
    Serial.println(number);

    // Increment the number and send it back
    Serial1.write((uint8_t*)&number, sizeof(number));  // Send incremented number to the master ESP32
  }
}
