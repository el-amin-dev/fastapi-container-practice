import os

import uvicorn
from fastapi import FastAPI

app = FastAPI(title="containerization-practice")


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/hello/{name}")
def hello(name: str):
    return {"message": f"hello, {name}"}


@app.get("/env")
def env():
    return {"greeting": os.getenv("APP_GREETING", "hi")}


if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000)
