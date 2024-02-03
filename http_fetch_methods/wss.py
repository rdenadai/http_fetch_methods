import asyncio

from fastapi import FastAPI, Request, WebSocket
from fastapi.staticfiles import StaticFiles

from http_fetch_methods.support.random_walk import randon_walk_wss
from http_fetch_methods.support.template import TEMPLATES

static = StaticFiles(directory="static", html=True)

app = FastAPI()
app.mount("/static", static, name="static")


@app.get("/")
async def index(request: Request):
    return TEMPLATES.TemplateResponse(request=request, name="wss.html")


@app.websocket("/wss")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    i = 0
    while True:
        step = await randon_walk_wss(i).__anext__()
        await websocket.send_json(step)
        await asyncio.sleep(1)
        i += 1
