# HW_CI_test
This template demonstrates how to use **FastAPI** as an API for continuous integration (CI) testing of the **ESP32**. It utilizes **Robot Framework** and **CoreMark** for testing.


## Only testing

Before proceeding, ensure that Docker is installed on your machine. To run the tests, use the following commands:

```bash
docker compose build

docer compose run test
```


## Launching the API Service Locally

To build the Docker image, deploy the containers, and start the API service in your local environment, follow these steps:

```bash
docker compose build

docker compose up -d

docker exec -it HW_CI_test /bin/bash

uvicorn src.main:app --host localhost --port 7877 --reload
```

