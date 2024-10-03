from fastapi.testclient import TestClient

from src.main import app


client = TestClient(app)


def test_test_create():
    response = client.get("/test_route/")
    assert response.status_code == 200
