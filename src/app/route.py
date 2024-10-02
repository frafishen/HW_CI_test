from fastapi import APIRouter


router = APIRouter()


@router.get("/test_route/")
async def test_create():
    return {"message": "Routing Successfully!"}
