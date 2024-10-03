# HW_CI_test
This template demonstrates how to use **FastAPI** as an API for continuous integration (CI) testing of the **ESP32**. It utilizes **Robot Framework** and **CoreMark** for testing.

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
├── requirements.txt
├── src
│   ├── app
│   │   └── route.py
│   └── main.py
└── tests
    ├── robot
    │   └── api_test.robot
    └── unit
        ├── app
        │   └── test_route.py
        └── test_main.py

12 directories, 17 files
```
