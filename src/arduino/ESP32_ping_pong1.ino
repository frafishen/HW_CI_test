// Using Serial1 for communication between ESP32s (Master)

unsigned long long number = 0;

void setup() {
  Serial.begin(115200);        // Serial monitor
  Serial1.begin(115200, SERIAL_8N1, 16, 17); // Using Serial1 for RX pin = 16, TX pin = 17
  
  Serial.println("Master ready. Starting Ping-Pong.");
  
  // Start the communication by sending the first number
  number = 1;
  Serial1.write((uint8_t*)&number, sizeof(number)); // Send the first number to the slave
}

void loop() {
  // Master receives and sends back incremented number
  if (Serial1.available() >= sizeof(number)) {
    Serial1.readBytes((char*)&number, sizeof(number)); // Read the received 64-bit number
    
    // Print the received number
    Serial.print("Received from Slave ESP32: ");
    Serial.println(number);
    
    // Increment the number and send it back
    number++;
    Serial1.write((uint8_t*)&number, sizeof(number)); // Send incremented number to the slave ESP32
  }
}
