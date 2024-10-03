from fastapi import APIRouter


router = APIRouter()


@router.get("/test_route/")
async def test_route():
    return {"message": "Routing Successfully!"}


@router.get("/items/{item_id}")
async def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}
