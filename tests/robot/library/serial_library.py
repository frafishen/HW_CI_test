import serial
import time

master_serial = None
slave_serial = None

def reset_board(port, baudrate=115200):
    """Reset the ESP32 board by toggling the DTR/RTS line."""
    with serial.Serial(port, baudrate) as ser:
        ser.dtr = False  # Pull the reset line low
        time.sleep(0.1)
        ser.dtr = True  # Release the reset line to reboot the board

def connect_to_device(port, baudrate=115200, expected_message="", role="Master"):
    """Connects to a device (Master/Slave) and waits for a specific message."""
    ser = serial.Serial(port, baudrate, timeout=1)
    time.sleep(2)  # Wait for the connection to stabilize

    received_data = ""
    start_time = time.time()
    while True:
        if time.time() - start_time > 10:  # Timeout after 10 seconds
            raise TimeoutError(f"Timeout while waiting for {role} ESP32 response")
        time.sleep(0.1)  # Add delay to ensure time to receive the data
        try:
            received_data = ser.readline().decode('utf-8').strip()  # Read and decode
            if received_data == expected_message:
                print(f"{role} connected: {received_data}")
                return ser
        except UnicodeDecodeError:
            print(f"Failed to decode data from {role}, trying again...")
        received_data = ""  # Reset for retry

def connect_to_master(port, baudrate=115200):
    """Connects to the master ESP32 and waits for the ready message."""
    global master_serial
    master_serial = connect_to_device(port, baudrate, "Master ready. Starting Ping-Pong.", role="Master")

def connect_to_slave(port, baudrate=115200):
    """Connects to the slave ESP32 and waits for the ready message."""
    global slave_serial
    slave_serial = connect_to_device(port, baudrate, "Slave ready. Waiting for communication.", role="Slave")

def read_serial_data(serial_device, prefix, role="device"):
    """Reads and extracts the number from the serial device based on the given prefix."""
    received_data = ""
    start_time = time.time()
    while not received_data:
        if time.time() - start_time > 10:  # Timeout after 10 seconds
            raise TimeoutError(f"Timeout while waiting for data from {role}")
        try:
            received_data = serial_device.readline().decode('utf-8').strip()  # Read full line and strip newline
        except UnicodeDecodeError:
            print(f"Failed to decode data from {role}, trying again...")
            received_data = ""  # Reset to try reading again

    if received_data.startswith(prefix):
        try:
            number = int(received_data.replace(prefix, "").strip())  # Convert to int
            return number
        except ValueError as e:
            raise ValueError(f"Failed to convert received data to int: {received_data} - Error: {str(e)}")
    else:
        raise ValueError(f"Unexpected data format from {role}: {received_data}")

def process_slave_serial():
    """Reads data from the slave ESP32 and returns the extracted number."""
    return read_serial_data(slave_serial, "Received from Master ESP32: ", role="slave")

def process_master_serial():
    """Reads data from the master ESP32 and returns the extracted number."""
    return read_serial_data(master_serial, "Received from Slave ESP32: ", role="master")

def close_connections():
    """Closes the serial connections for both master and slave ESP32 devices."""
    global master_serial, slave_serial
    try:
        if master_serial:
            master_serial.close()
            master_serial = None
        if slave_serial:
            slave_serial.close()
            slave_serial = None
    except Exception as e:
        print(f"Error closing connections: {str(e)}")

