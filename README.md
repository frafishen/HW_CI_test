# HW_CI_test
This template demonstrates how to use **FastAPI** as an API for continuous integration (CI) testing of the **ESP32**. The CI pipeline is implemented using **Jenkins** and leverages **Robot Framework** for automated testing.

## Testing Report
[Testing Report Shortcut](report/report.md)

## Launching the API Service Locally

To build the Docker image, deploy the containers, and start the API service in your local environment, follow these steps:

```bash
docker compose build

docker compose up -d

docker exec -it HW_CI_test /bin/bash

uvicorn src.main:app --host localhost --port 7877 --reload
```

## Folder Structure
```bash
.
├── Dockerfile
├── Jenkinsfile
├── README.md
├── conftest.py
├── docker-compose.yml
├── pytest.ini
├── report
│   └── report.md
├── requirements.txt
├── src
│   ├── app
│   │   └── route.py
│   ├── arduino
│   │   ├── ESP32_ping_pong1.ino
│   │   └── ESP32_ping_pong2.ino
│   └── main.py
└── tests
    ├── robot
    │   ├── api_test.robot
    │   ├── library
    │   │   └── serial_library.py
    │   └── test_esp32_communication.robot
    └── unit
        ├── app
        │   └── test_route.py
        └── test_main.py

15 directories, 22 files
```
